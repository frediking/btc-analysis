# Install and load packages
install.packages("quantmod")
library(quantmod)
# Set the start and end dates for your data
start_date <- as.Date("2023-01-01")
end_date <- as.Date("2024-01-01")

# Get Bitcoin data (BTC-USD is Yahoo Finance's ticker for Bitcoin)
btc_data <- getSymbols("BTC-USD", 
                       src = "yahoo",
                       from = start_date,
                       to = end_date,
                       auto.assign = FALSE)
# Convert to data frame format for easier manipulation
btc_df <- data.frame(Date=index(btc_data), coredata(btc_data))

# Rename columns for clarity
names(btc_df) <- c("Date", "Open", "High", "Low", "Close", "Volume", "Adjusted")

head(btc_df)
str(btc_df)

# load all required packages for calculating metrics
install.packages(c("TTR", "zoo"))
library(ggplot2)
library(dplyr)
library(TTR)
library(zoo)

#calculating metrics (daily returns, volatility, RSI) and adding them as 
#new columns
btc_df <- btc_df %>%
  mutate(
    Daily_Return = c(NA, diff(log(Close))),
    Volatility = rollapply(Daily_Return, width=20, FUN=sd, fill=NA) * sqrt(252),
    SMA_20 = SMA(Close, n=20),  # 20-day moving average
    SMA_50 = SMA(Close, n=50),  # 50-day moving average
    RSI = RSI(Close)  # Relative Strength Index
  )
head(btc_df)

# calculating summary statistics
summary_stats <- data.frame(
  Mean_Return = mean(btc_df$Daily_Return, na.rm=TRUE),
  Annual_Volatility = sd(btc_df$Daily_Return, na.rm=TRUE) * sqrt(252),
  Max_Price = max(btc_df$High),
  Min_Price = min(btc_df$Low),
  Avg_Volume = mean(btc_df$Volume)
)
print(summary_stats)

#creating a bitcoin price trends plot
price_plot <- ggplot(btc_df, aes(x=Date, y=Close)) +
  geom_line(color="blue") +
  labs(title="Bitcoin Price Over Time",
       y="Price (USD)",
       x="Date") +
  theme_minimal()

print(price_plot)

# Create technical analysis plot
technical_plot <- ggplot(btc_df, aes(x=Date)) +
  geom_line(aes(y=Close, color="Price")) +
  geom_line(aes(y=SMA_20, color="20-day MA")) +
  geom_line(aes(y=SMA_50, color="50-day MA")) +
  scale_color_manual(values=c("Price"="black", "20-day MA"="blue", "50-day MA"="red")) +
  labs(title="Bitcoin Price with Moving Averages",
       y="Price (USD)",
       x="Date",
       color="Metrics") +
  theme_minimal()
print(technical_plot)

# Create volatility plot
volatility_plot <- ggplot(btc_df, aes(x=Date, y=Volatility)) +
  geom_line(color="red") +
  labs(title="Bitcoin 20-day Rolling Volatility (Annualized)",
       y="Volatility",
       x="Date") +
  theme_minimal()
print(volatility_plot)

# Create RSI plot
rsi_plot <- ggplot(btc_df, aes(x=Date, y=RSI)) +
  geom_line(color="purple") +
  geom_hline(yintercept=c(30,70), linetype="dashed", color="gray") +
  labs(title="Relative Strength Index (RSI)",
       y="RSI",
       x="Date") +
  theme_minimal()
print(rsi_plot)






