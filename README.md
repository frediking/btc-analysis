# Bitcoin Price Analysis Project

 This project analyzes Bitcoin price data from January 2023 to January 2024 using R Programming language . The analysis includes price trends, volatility measurements, and technical indicators.
## Authors

- [@fredinardd]  - X
- (https://www.github.com/frediking)


## Data Source

Data is retrieved from Yahoo Finance using the “quantmod” package in R. The dataset includes daily Open, High, Low, Close, Volume data for Bitcoin ( BTC-USD )

## Key Metrics Analyzed
1. **Price Statistics**
- Price Range : $16,521 - $44,706
- Mean Price : $28,901

2. **Volatility Analysis**
- Range : 12.29% - 65.51%
- Median : 35.33%

3. **Daily Returns**
- Maximum : +9.81%
- Minimum : -7.36%
- Mean : +0.27%

4. **Technical Indicators**
- RSI (Relative Strength Index)
- 20-day Simple Moving Average
- 50-day Simple Moving Average

## Code Implementation
**Data Import in R**

```R

# Install and load packages
- library(quantmod)
- library(ggplot2)
- library(dplyr)
- library(TTR)
- library(zoo)

# Get Bitcoin Data
btc_data  <- getSymbols(“BTC-USD”, src = “yahoo”,
from = start_date, 
to = end_date,
auto.assign = FALSE 

}
```
**Analysis Implementation**

```R

# Calculate metrics and add as new fields to the data frame.

btc_df <- btc_df  %>% 
mutate(
    Daily_Return = c(NA, diff(log(Close))),
    Volatility = rollapply(Daily_Return, width=20, FUN=sd, fill=NA) * sqrt(252),
    SMA_20 = SMA(Close, n=20),
    SMA_50 = SMA(Close, n=50),
    RSI = RSI(Close)
  )
   ```

**Visualizations Code**

```R

# Basic price over time and volume visualization

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
 

#VISUALIZATIONS FOR BITCOIN PRICE TRENDS OVER TIME , PRICE WITH TECHNICAL INDICATORS , VOLATILITY TRENDS and the RSI INDICATOR 
```


## Visualizations
The project includes several visualizations:
1. Price trends over time
2. Moving averages overlay
3. Volatility patterns
4. RSI indicator

## Key Findings
- Overall bullish trend throughout 2023
- Significant price appreciation (>100% from lowest to highest point)
- Moderate to high volatility, typical for cryptocurrency markets
- Multiple trading opportunities identified through technical indicators

## Requirements
- R (version 4.0 or higher)
- Required packages: quantmod, ggplot2, dplyr, TTR, zoo

## Usage
1. Clone the repository
2. Install required R packages
3. Run the analysis scripts
4. View generated visualizations and metrics

## License

This project is licensed under the [MIT License](LICENSE).  
You are free to use, modify, and distribute this project. See the LICENSE file for more details.


## Contributing

Contributions are always welcome!  

### Ways to Contribute
- **Report Bugs**: Found a bug? Open an issue and include steps to reproduce it.
- **Suggest Features**: Have an idea? Share it through an issue.
- **Submit Code**: Fork the repository, make your changes, and create a pull request.

Please adhere to this project's [`code of conduct`](CODE_OF_CONDUCT.md).
