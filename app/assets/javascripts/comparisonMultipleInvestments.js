/* global $, Highcharts */
$(function() {

    var tickers = [];
    for (var i = 0; i < gon.investmentPortfolios.length; i++) {
      tickers.push(gon.investmentPortfolios[i].ticker);
    }

    var seriesOptions = [],
        seriesCounter = 0;

    /**
     * Create the chart when all data is loaded
     * @returns {undefined}
     */
    function createChart() {

        Highcharts.stockChart('comparison-series', {

            rangeSelector: {
                selected: 4
            },

            yAxis: {
                labels: {
                    formatter: function() {
                        return (this.value > 0 ? ' + ' : '') + this.value + '%';
                    }
                },
                plotLines: [{
                    value: 0,
                    width: 2,
                    color: 'silver'
                }]
            },

            plotOptions: {
                series: {
                    compare: 'percent',
                    showInNavigator: true
                }
            },

            tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
                valueDecimals: 2,
                split: true
            },

            series: seriesOptions
        });
    }

    $.each(tickers, function(i, ticker) {

        $.getJSON('https://www.quandl.com/api/v3/datasets/YAHOO/' + tickers[i] + '/data.json?start_date=2006-01-01&column_index=6&order=asc&api_key=AVB8P1K72xSZsU2SyFZN', function(stockData) {
            console.log(stockData);
            var pricesArray = stockData.dataset_data.data.map(function(d) {
              return [new Date(d[0]).getTime(), d[1]];
            });

            seriesOptions[i] = {
                name: ticker,
                data: pricesArray
            };

            // As we're loading the data asynchronously, we don't know what order it will arrive. So
            // we keep a counter and create the chart when all the data is loaded.
            seriesCounter += 1;

            if (seriesCounter === tickers.length) {
                createChart();
            }
        });
    });
});
