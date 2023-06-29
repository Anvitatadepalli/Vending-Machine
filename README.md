# Vending-Machine

## Introduction
Automation has revolutionized the world. Today instead of shopkeepers selling items manually, we have automatic machines accepting money and dispensing products. Vending machines are devices where the customers insert coins or credit cards to purchase newspapers, snacks, beverages, tickets, etc. It is the most practical method of purchasing.  
A vending machine is a sequential circuit that dispenses various products when money is inserted. This is a modeling of the Finite State-based Vending Machine using the Moorey model. The code for the vending machine is written in Verilog HDL and simulated in the Model Sim.

### The products available in the machine are: 
![image](https://github.com/Anvitatadepalli/Vending-Machine/assets/98482161/31d4c288-34d0-420c-8d44-4478c2a02757)

### The buyer can insert money of the following denomination :
Rs. 10  
Rs. 20


## working
<img src="https://github.com/Anvitatadepalli/Vending-Machine/assets/98482161/965f9ba3-d0d2-4ef6-a65c-165a5fdc3b8b" width="500">  

==> The machine will remain in an ideal state until the user selects a product.  

==> If the product is available the machine will move to the money insertion state and in case the product is out of stock, the machine will go back to an ideal state.  

==> In the money insertion state the machine will wait for the user to insert money and if enough money is inserted the machine will move to the product delivery state.  

==> In the product delivery state, the machine will dispense the product along with the change in case more money than required is inserted.  

==> After the product delivery the machine will move back to the ideal case waiting for the user to enter selection input.

==> In case of no product, the machine will move into the service state and remain there until the machine is reset.  

## State Diagram
<img src="https://github.com/Anvitatadepalli/Vending-Machine/assets/98482161/2ee5f203-54ff-4948-9e14-a451c805e76e" width="750">  

**Thus the vending machine was successfully designed using Verilog HDL and simulated using Model Sim.**






