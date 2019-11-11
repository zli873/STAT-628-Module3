import pandas as pd
df = pd.read_csv('/content/drive/My Drive/628 module3/bars/bars_review.csv')
df_pos = df[df['stars'] == 5]
df_neg = df[df['stars'] <= 2]

raw_documents_pos = list(df_pos['text'])
raw_documents_neg = list(df_neg['text'])



from sklearn.feature_extraction.text import CountVectorizer
# use a custom stopwords list, set the minimum term-document frequency to 20
vectorizer_pos = CountVectorizer(stop_words = 'english', min_df = 20)
vectorizer_neg = CountVectorizer(stop_words = 'english', min_df = 20)
A_pos = vectorizer_pos.fit_transform(raw_documents_pos)
A_neg = vectorizer_neg.fit_transform(raw_documents_neg)
print( "Created %d X %d document-term matrix for positive reviews" % (A_pos.shape[0], A_pos.shape[1]) )
print( "Created %d X %d document-term matrix for negative reviews" % (A_neg.shape[0], A_neg.shape[1]) )


terms_pos = vectorizer_pos.get_feature_names()
print("Vocabulary for positive reviews has %d distinct terms" % len(terms_pos))
terms_neg = vectorizer_neg.get_feature_names()
print("Vocabulary for negative reviews has %d distinct terms" % len(terms_neg))


from sklearn.externals import joblib
joblib.dump((A_pos,terms_pos,raw_documents_pos), "articles-raw-pos.pkl")



from sklearn.feature_extraction.text import TfidfVectorizer
# we can pass in the same preprocessing parameters
# Load the regular expression library
import re
raw_documents_neg = df_neg.text
# Remove punctuation
raw_documents_neg = raw_documents_neg.map(lambda x: re.sub('[,\.!?]', '', x))
# Convert the titles to lowercase
raw_documents_neg = raw_documents_neg.map(lambda x: x.lower())
# Print out the first rows of papers
raw_documents_neg.head()

vectorizer = TfidfVectorizer(stop_words='english', min_df = 20)
A_neg = vectorizer.fit_transform(raw_documents_neg)
print( "Created %d X %d TF-IDF-normalized document-term matrix" % (A_neg.shape[0], A_neg.shape[1]) )

# extract the resulting vocabulary
terms_neg = vectorizer.get_feature_names()
print("Vocabulary for negative reviews has %d distinct terms" % len(terms_neg))



import operator
def rank_terms( A, terms ):
    # get the sums over each column
    sums = A.sum(axis=0)
    # map weights to the terms
    weights = {}
    for col, term in enumerate(terms):
        weights[term] = sums[0,col]
    # rank the terms by their weight over all documents
    return sorted(weights.items(), key=operator.itemgetter(1), reverse=True)



ranking = rank_terms( A_neg, terms_neg )
for i, pair in enumerate( ranking[0:50] ):
    print( "%02d. %s (%.2f)" % ( i+1, pair[0], pair[1] ) )

