library(reshape2)
library(tm)
library(SnowballC)
library(wordcloud)
library(ggplot2)

sotu_source <- DirSource(
  directory = file.path('sotu'),
  encoding = 'UTF-8',
  pattern = '*.txt',
  recursive = FALSE,
  ignore.case = FALSE)

sotu_corpus <- Corpus(
  sotu_source,
  readerControl = list(
    reader = readPlain,
    language = 'en'))

sotu_corpus <- tm_map(sotu_corpus, tolower)

sotu_corpus <- tm_map(
  sotu_corpus,
  removePunctuation,
  preserve_intra_word_dashes = TRUE)

sotu_corpus <- tm_map(
  sotu_corpus,
  removeWords,
  stopwords('english'))

sotu_corpus <- tm_map(
  sotu_corpus,
  stemDocument,
  lang = 'porter')

sotu_corpus <- tm_map(
  sotu_corpus, 
  stripWhitespace)

sotu_tdm <- TermDocumentMatrix(sotu_corpus)
sotu_matrix <- as.matrix(sotu_tdm)
sotu_df <- data.frame(sotu_matrix)
names(sotu_df) <- 
sotu_df$word <- rownames(sotu_df)
rownames(sotu_df) <- NULL
sotu_melted_df <- melt(sotu_df, id.vars='word')

p <- ggplot(bar_df, aes(x = word, y = freq)) +
  geom_line(stat = "identity", fill = "grey60") +
  ggtitle("The State of George Washington's Union") +
  xlab("Top 10 Word Stems (Stop Words Removed)") +
  ylab("Frequency") +
  theme_minimal() +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme(panel.grid = element_blank()) +
  theme(axis.ticks = element_blank()) +
  coord_flip()

print(p)