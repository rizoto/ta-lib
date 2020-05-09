//
//  main.swift
//  test-swift
//
//  Created by Lubor Kolacny on 9/5/20.
//

import Foundation

var res = TA_Initialize();
if(res != TA_SUCCESS)
   {
       print("Error TA_Initialize:", res);
       exit(-1)
   }

let data = [105.68, 93.74, 92.72, 90.52, 95.22, 100.35, 97.92, 98.83, 95.33,
93.4, 95.89, 96.68, 98.78, 98.66, 104.21, 107.48, 108.18, 109.36,
106.94, 107.73, 103.13, 114.92, 112.71, 113.05, 114.06, 117.63,
116.6, 113.72, 108.84, 108.43, 110.06, 111.79, 109.9, 113.95,
115.97, 116.52, 115.82, 117.91, 119.04, 120, 121.95, 129.08,
132.12, 135.72, 136.66, 139.78, 139.14, 139.99, 140.64, 143.66]

let data_size:Int32 = Int32(data.count)
let res_size = data_size - TA_MACD_Lookback(12, 26, 9)

var outMACD = Array<Double>(repeating: 0.0, count:Int(res_size))
var outMACDSignal = Array<Double>(repeating: 0.0, count:Int(res_size))
var outMACDHist = Array<Double>(repeating: 0.0, count:Int(res_size))

var outBegIdx:Int32 = 0
var outNbElement:Int32 = 0

res = TA_MACD(0, data_size-1,                       // data range
              data,                                 // data pointer
              12, 26, 9,                            // TA Func specific args
              &outBegIdx, &outNbElement,            // relative index and size of results
              &outMACD, &outMACDSignal, &outMACDHist); // arrays of results

if (res == TA_SUCCESS) {
    for i in 0...outNbElement-1 {
        print("Result for day \(outBegIdx+i) outMACD: \(outMACD[Int(i)]) outMACDSignal: \(outMACDSignal[Int(i)]) outMACDHist: \(outMACDHist[Int(i)])")
       }
} else {
       print("Error TA_MACD:", res);
}

res = TA_Shutdown();
if(res != TA_SUCCESS)
{
    print("Error TA_Shutdown:", res)
    exit(-1)
}

/*
 results from test-ta++
 Result for day #33 outMACD: 4.273859 outMACDSignal: 5.671647 outMACDHist: -1.397788
 Result for day #34 outMACD: 4.345092 outMACDSignal: 5.406336 outMACDHist: -1.061244
 Result for day #35 outMACD: 4.395259 outMACDSignal: 5.204121 outMACDHist: -0.808861
 Result for day #36 outMACD: 4.328635 outMACDSignal: 5.029024 outMACDHist: -0.700388
 Result for day #37 outMACD: 4.393831 outMACDSignal: 4.901985 outMACDHist: -0.508154
 Result for day #38 outMACD: 4.484981 outMACDSignal: 4.818584 outMACDHist: -0.333603
 Result for day #39 outMACD: 4.581865 outMACDSignal: 4.771241 outMACDHist: -0.189375
 Result for day #40 outMACD: 4.761112 outMACDSignal: 4.769215 outMACDHist: -0.008103
 Result for day #41 outMACD: 5.416065 outMACDSignal: 4.898585 outMACDHist: 0.517480
 Result for day #42 outMACD: 6.109990 outMACDSignal: 5.140866 outMACDHist: 0.969124
 Result for day #43 outMACD: 6.871214 outMACDSignal: 5.486936 outMACDHist: 1.384278
 Result for day #44 outMACD: 7.464296 outMACDSignal: 5.882408 outMACDHist: 1.581888
 Result for day #45 outMACD: 8.092786 outMACDSignal: 6.324483 outMACDHist: 1.768303
 Result for day #46 outMACD: 8.441914 outMACDSignal: 6.747970 outMACDHist: 1.693945
 Result for day #47 outMACD: 8.687049 outMACDSignal: 7.135785 outMACDHist: 1.551264
 Result for day #48 outMACD: 8.831961 outMACDSignal: 7.475021 outMACDHist: 1.356940
 Result for day #49 outMACD: 9.085758 outMACDSignal: 7.797168 outMACDHist: 1.288590
 */
