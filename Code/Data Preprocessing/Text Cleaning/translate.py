import pandas as pd
from textblob import TextBlob
from parse import proc_text
from langdetect import detect

TRAIN_CSV = 'train_data.csv'
TRAIN_TEXT = 'text_train.csv'
TRAIN_TRANS = 'train_trans.csv'


# Imputate the null values.
def index_na(text):
    """
    The reviews written in foreign language become NA after cleaning.
    The index_na function will find them out.
    """
    na_text = text[text.isnull().values == True]
    na_list = na_text.index.tolist()
    return na_list


def translate(input_csv, text_csv, trans_csv):
    "Translate the reviews"
    text = pd.read_csv(text_csv)
    table = pd.read_csv(input_csv)
    trans = pd.DataFrame(columns=['trans_text'])

    na = index_na(text)
    new_text = []
    for i in table.index.tolist():
        if i in na:
            t = table.loc[i, 'text']
            try:
                from_lng = detect(t)
            except:
                from_lng = "error"
            blob = TextBlob(t)
            if from_lng != 'error':
                t_new = proc_text(str(blob.translate(from_lang=from_lng, to="en")))
            else:
                t_new = t
            new_text.append(t_new)
        else:
            new_text.append(text.loc[i, 'clean'])
    trans['trans_text'] = pd.Series(new_text)
    trans['stars'] = text[['stars']]

    trans.to_csv(trans_csv, sep=',', encoding='utf-8', header=True,
                 doublequote=True, index=False)


def main():
    translate(TRAIN_CSV, TRAIN_TEXT, TRAIN_TRANS)


if __name__ == '__main__':
    main()
