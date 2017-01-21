/* global $, Highcharts */
$(function() {

    var investmentID = gon.investment.id;
    var investmentName = gon.investment.name;

    $.getJSON('/api/v1/stockprices/' + investmentID, function(stockData) {

        console.log(stockData);
        var pricesArray = stockData.daily_prices.map(function(d) {
          return [new Date(d[0]).getTime(), d[1]];
        });

        // Create the chart
        Highcharts.stockChart('single-series-investment', {

            rangeSelector: {
                selected: 1
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

            title: {
                text: investmentName + ' ' + 'Performance'
            },
            series: [{
                data: pricesArray

            }],
        });
    });
});
