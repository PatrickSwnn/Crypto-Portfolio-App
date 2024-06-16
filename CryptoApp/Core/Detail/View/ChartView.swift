//
//  ChartView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 28/05/2024.
//

import SwiftUI

struct ChartView: View {
    
    private let data : [Double]
    private let maxY : Double
    private let minY : Double
    private let lineColor : Color
    private let startingDate : Date
    private let endingDate : Date
    @State private var chartCompletionPercent:CGFloat = 0.0
    
    init(coin:CoinModel){
        data = coin.sparklineIn7D?.price ?? [] // blank array if there is no data
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        // get the price change by - of the last X and first X
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        endingDate = Date.init(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
        //since there are 7 days in a week 24 hours in a day 60 mins in an hour and 60 seconds in a day and since it has to be go backwards -
        
    }
    
    var body: some View {
      
        chart
            .frame(height:200)
            .background(chartBackground)
            .overlay(chartHeaders.padding(.horizontal,4),alignment: .leading)
        chartDateLabels
            .padding(.horizontal,4)
      
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                    withAnimation(.linear(duration: 2.0)){
                        chartCompletionPercent = 1.0
                    }
                }
            })
        
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.shared.coin)
}

extension ChartView {
    private var chart : some View {
        //embed the entire view in the geometry reader
        GeometryReader { proxy in
            //in iOS, minX,minY is topLeftCorner and maxX,maxY is topRightCorner
            Path { path in
                
                //here, we are looping the indexes of the data array, not the price values
                for index in data.indices {
                    
                    let xPosition = (proxy.size.width / CGFloat(data.count)) * CGFloat(index+1) //since data.count starts from 1.
                    /*
                     imagine phone size of width 300
                     300
                     100
                     3 * 1 = 3
                     3 * 2 = 6
                     3 * 3 = 9
                     ...
                     3 * 100 = 300
                     //its a way to fit in all of the data inside the phone screen
                     */
                    
                    
                    let yAxis = maxY - minY
                    //if max = 50000,min = 40000 : 50000 - 40000 = 10000 since we need to know the difference
                    
                    let yPosition =  (1 - ((data[index] - minY) / yAxis))  * proxy.size.height
                
                    /* imagine a data point of 42000 :
                    42000-40000 = 2000 / 10000 = 20%
                     subtracting from the min value and dividing with the difference of MaxY and MinY to know how much percent of that data point should go up
                     and multiply that with the geometry div height to take place the entire phone height
                     note that in iOS apps, charts go reverse, it positive, they goes down
                     In order to reverse the chart, we subtract everything from 1
                     
                     
                    */
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition)) //if it is in the first loop
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
                
            }
            .trim(from: 0,to:chartCompletionPercent)
            .stroke(lineColor,style:StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
            .shadow(color:lineColor,radius: 10,x:0,y:10)
            .shadow(color:lineColor.opacity(5),radius: 10,x:0,y:20)
            .shadow(color:lineColor.opacity(0.2),radius: 10,x:0,y:30)
            .shadow(color:lineColor.opacity(0.1),radius: 10,x:0,y:40)

            
        }
    }
    
    private var chartBackground : some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartHeaders : some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            let midPrice = (maxY+minY) / 2
            Text(midPrice.formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    
    private var chartDateLabels : some View {
        HStack{
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
    
}
