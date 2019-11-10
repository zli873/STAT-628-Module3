import pandas as pd
import nltk
from nltk.stem.snowball import SnowballStemmer
import re

TRAIN_CSV = 'train_data.csv'
TRAIN_OUT = 'new_train.csv'
TRAIN_TEXT = 'text_train.csv'
TRAIN_TRANS = 'train_trans.csv'

snowball = SnowballStemmer('english')


### Text cleaning
def proc_text(text):
    "Cleaning text."
    # Noise removing
    new_text = re.sub("n't", ' not', text)

    # Removing punctuation and numbers
    new_text = re.sub('[^0-9a-zA-Z]', ' ', new_text)

    # Converting text to lower case
    new_text = new_text.lower()

    # Tokenizing text into bags of words
    new_text = nltk.word_tokenize(new_text)

    # Stemming and Lemmatizing
    new_text = [snowball.stem(word) for word in new_text]

    return ' '.join(new_text).replace("\n","")


def make_text(input_csv, output_csv):
    # Save cleaned text into a csv file
    table = pd.read_csv(input_csv)
    new_table = table[['text']].copy()

    # Add a cleaned text column
    new_table['clean'] = pd.Series([proc_text(t) for t in new_table['text']])

    # Write to a new file
    new_table.to_csv(output_csv, sep=',', encoding='utf-8', header=True,
                     doublequote=True, index=False)


def combine(input_csv, text_csv):
    # Add stars into the text csv
    text = pd.read_csv(text_csv)
    table = pd.read_csv(input_csv)
    text['stars'] = table[['stars']]

    # Write to a new file
    text.to_csv(text_csv, sep=',', encoding='utf-8', header=True,
                 doublequote=True, index=False)


### Main function
def main():
    combine(TRAIN_CSV, TRAIN_TEXT)


if __name__ == '__main__':
    main()
