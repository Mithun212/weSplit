//
//  ContentView.swift
//  WeSplit
//
//  Created by mithun srinivasan on 07/02/23.
//

import SwiftUI


struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var noOfPersons = 2
    @State private var tipsPercentage = 20
        
    @FocusState private var isFocused: Bool

    let tipsChoice = [10,15,20,25,0]
    
    var total: Double {
        let tipPercent = Double(tipsPercentage)
        let tipValue = billAmount / 100 * tipPercent
        let newTotal = billAmount + tipValue
        return newTotal
    }
    var totalPerPerson: Double {
        let persons = Double(noOfPersons + 2)
        let selectedTipPercentage = Double(tipsPercentage)
        
        let tipValue = billAmount / 100 * selectedTipPercentage
        let totalAmount = billAmount + tipValue
        let totalperperson = totalAmount/persons
        return totalperperson
    }
    
        
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                    
                    Picker("No Of People", selection: $noOfPersons) {
                        ForEach(2..<10) { Text("\($0) persons") }
                    }
                }
                
                Section{
                    Picker("Tip precentage", selection: $tipsPercentage) {
                        ForEach(tipsChoice, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .foregroundColor(tipsPercentage == 0 ? .red : .black)

//                    .pickerStyle(.segmented)
                } header: {
                    Text("how much tip do u wanna leave")
                }
                
                Section{
                    Text(totalPerPerson,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {Text("Amount per Person")}
                
                Section{
                    Text(total,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {Text("total bill plus tip")}
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
