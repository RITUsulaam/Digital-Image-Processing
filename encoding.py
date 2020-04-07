# Importing Required Libraries
import random 
import numpy as np
import math

# Function to get binary value of a decimal value
def decimal_to_binary(digit):
    # If number is zero return 0000
    if (digit == 0):
        return '0000'
    
    # If number is from 1 to 15 return binary value in 4 bits 
    elif ((digit > 0) and (digit < 16)):
        bin_value = ''
        for i in range(4):
            # To get binary value divide the number by 2 each time 
            # Storing remainder in string 
            bin_value = bin_value + str(digit % 2)
            digit = digit // 2
        # To get binary value reverse the string as we take remainder in reverse order    
        return bin_value[::-1]
    
    # If number is greater than 15 return binary value in required number of bits
    else:
        # Calculating number of bits required to represent given number in binary
        no_of_bits = math.floor(math.log2(digit)) + 1
        bin_value = ''
        for i in range(no_of_bits):
            # To get binary value divide the number by 2 each time 
            # Storing remainder in string 
            bin_value = bin_value + str(digit % 2)
            digit = digit // 2
        # To get binary value reverse the string as we take remainder in reverse order     
        return bin_value[::-1]

# Function to get Run Length ENcoding of given bit stream
def run_length_encoding(bit_stream):
    # Convert Input Bit Stream in an array
    bit_stream = np.asarray(bit_stream)
    print('Input Bit Stream : ')
    # Print array of input bit stream
    print(bit_stream)

    # List to store the bit followed by its count in decimal
    decimal_encoding = []
    
    # List to store the bit followed by its count in binary
    binary_encoding = []
    
    # Previous bit
    prev_bit = ''
    
    # Initial Count = 0
    count = 0

    # Getting count in decimal as well as in binary
    for j in range(len(bit_stream)):
        
        # If present bit is equal to previous bit increment the count
        if (bit_stream[j] == prev_bit):
            count = count + 1

        # If present bit is not equal to previous bit then store the count value 
        # in decimal in decimal_encoding list and in binary in binary_encoding list
        # Also, make count equal to 1 as we got new bit i.e. different from previous bit
        else:
            # Combining bit and its count(decimal)
            decimal_encoded_value = str(prev_bit) + str(count)
            
            # Combining bit and its count(binary)
            binary_encoded_value = str(prev_bit) + str(decimal_to_binary(count))

            # Store these values in particular list
            decimal_encoding.append(decimal_encoded_value)
            binary_encoding.append(binary_encoded_value)
            
            # Make count equal to 1 as we got new bit i.e. different from previous bit
            count = 1
        
        # Now previous bit = present bit for next bit
        prev_bit = bit_stream[j]
    
    
    # Now store the last bit and its count in particular list
    decimal_encoding.append(str(prev_bit) + str(count))
    # Print decimal_encoding list which contain bit followed by its count in decimal
    print('\nEach Bit and its count in decimal : ')
    print(decimal_encoding[1:])

    # Print binary_encoding list which contain bit followed by its count in binary
    binary_encoding.append(str(prev_bit) + str(decimal_to_binary(count)))
    final_encoding = binary_encoding[1:]
    print('\nEach Bit and its count in binary : ')
    print(final_encoding)

    # Converting this list binary_encoding into an array
    s = ''
    for i in final_encoding:
        s = s + i

    l = []
    for i in s:
        l.append(int(i))

    # Printing an array of final encoded output in binary
    rle_output = np.asarray(l)
    print('\nFinal Encoded Output : ')
    print(rle_output)

    
    # Computing if it is negative compression or positive compression
    # If length of Run Length Encoded output is less than input bit stream then 
    # it is positive compression otherwise it is negative compression
    if (len(rle_output) < len(bit_stream)):
        # Printing length of input bit stream array
        print('\nLength of Input Bit Stream(N1) : ', len(bit_stream))
        
        # Printing Length of Run Length Encoded output array
        print('Length of Final Encoded Output(n2) : ', len(rle_output))
        print(len(rle_output), '(N2) < (N1)', len(bit_stream))
        
        # Stating that it is positive Compression
        print('Hence, it is a Positive Compression')
        
        # Printing Compression Ratio
        print('Compression Ratio (N1/N2) = ',len(bit_stream)/len(rle_output))

        
    elif (len(rle_output) > len(bit_stream)):
        # Printing length of input bit stream array
        print('\nLength of Input Bit Stream(N1) : ', len(bit_stream))
        
        # Printing Length of Run Length Encoded output array
        print('Length of Final Encoded Output(N2) : ', len(rle_output))
        print(len(rle_output), '(N2) > (N1)', len(bit_stream))
        
        # Stating that it is positive Compression
        print('Hence, it is a Negative Compression')
