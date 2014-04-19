library(reshape2)
library(tm)
library(SnowballC)
library(wordcloud)
library(ggplot2)

#### Munge corpus ####

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
  removeWords, 
  c("will", "can", "get", "that", "year", "let"))

sotu_corpus <- tm_map(
  sotu_corpus,
  stemDocument,
  lang = 'porter')

sotu_corpus <- tm_map(
  sotu_corpus, 
  stripWhitespace)

#### Coerce corpus to dataframe ####

sotu_tdm <- TermDocumentMatrix(sotu_corpus)
sotu_matrix <- as.matrix(sotu_tdm)
sotu_df <- data.frame(sotu_matrix)
names(sotu_df) <- gsub("\\.txt", "", names(sotu_df))
names(sotu_df) <- gsub("sotu", "", names(sotu_df))
#sotu_df$total <- rowSums(sotu_df)
sotu_df$outlieriness <- apply(sotu_df, 1, function(x) { max(x) - mean(x)})
sotu_df$word <- rownames(sotu_df)
rownames(sotu_df) <- NULL
sotu_melted_df <- melt(sotu_df, id.vars=c('word', 'outlieriness'))
sotu_melted_df <- sotu_melted_df[with(sotu_melted_df, 
                                      order(outlieriness,
                                            decreasing = TRUE)), ]
sotu_melted_df <- subset(sotu_melted_df, outlieriness > 150)

#### Visualize outliers ####

p <- ggplot(sotu_melted_df, 
            aes(x = variable, 
                y = value,
                group = word,
                colour = word)) +
  geom_line(alpha=.5) +
  ggtitle("Keyword outliers in the State of the Union:\n the outsized impact of wars") +
  ylab("Word Frequency") +
  theme_minimal() +
  scale_x_discrete(expand = c(0, 0),
                   breaks = seq(1790, 2014, 10)) +
  scale_y_continuous(expand = c(0, 0)) +
  annotate("text", 
           x = c(70, 120, 145, 145, 50, 210, 210, 210), 
           y = c(150, 120, 200, 180, 100, 210, 195, 180), 
           label = c('Mexico', 'Nation/Congress', 'Dollar', 'War', 'War', 'Nation', 'Congress', 'Program')) +
  theme(axis.ticks.x = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text.x = element_text(angle=45,
                                   vjust=.4),
        axis.title.x = element_blank(),
        legend.position='none')

print(p)
ggsave('outliers.png', width=10, height = 5)

#### Word cloud  ####
png('wordcloud.png')
sample <- as.matrix(sotu_tdm[, c(1, 56, 112, 168, 223)])
colnames(sample) <- c('1790', '1845', '1901', '1958', '2014')
comparison.cloud(sample, title.size=3, max.words=200, )
dev.off()