/* global $, Highcharts */
$(function() {

    $.getJSON('https://www.quandl.com/api/v3/datasets/YAHOO/index_gspc/data.json?start_date=190-01-01&column_index=6&order=asc&api_key=AVB8P1K72xSZsU2SyFZN', function(stockData) {

        var pricesArray = stockData.dataset_data.data.map(function(d) {
          return [new Date(d[0]).getTime(), d[1]];
        });

        // var chartData = [];
        // $.each(pricesArray, function(index, value) {
        //     var dailyPrices = (value);
        //     console.log(dailyPrices);
        //     chartData.push(dailyPrices);
        // });

        // console.log(data.dataset_data.data[0][1]);

        // Create the chart
        Highcharts.stockChart('single-series', {
            rangeSelector: {
                selected: 1
            },
            title: {
                text: 'S&P 500 Performance'
            },
            series: [{
                name: 'S&P500',
                data: pricesArray,
                tooltip: {
                    valueDecimals: 2
                }
            }],
        });
    });
});
