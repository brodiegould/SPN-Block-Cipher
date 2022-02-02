%function call
function SPN(plainText,key1,key2,key3)

%read plaintext and convert to an array
plainText
a = dec2bin(plainText,4);
ptArray = str2num(a')';

%read key 1 and convert to an array
a = dec2bin(key1,4);
key1Array = str2num(a')';

%read key 1 and convert to an array
a = dec2bin(key2,4);
key2Array = str2num(a')';

%read key 1 and convert to an array
a = dec2bin(key3,4);
key3Array = str2num(a')';

%%%%%%%%%%%%%%%%%%%%%%START OF OPERATIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%n = # of rounds
for n= 1:20

%Xor with Key1
if n== 1 
    afterKey1 = xor(ptArray,key1Array);
else
    afterKey1 = xor(afterSPN2,key1Array);
end 
%Split array into two pieces
inputLeftSPN = afterKey1(1,1:2);
inputRightSPN = afterKey1(1,3:4);

outputLeftSPN = [0,0];
outputLeftSPN2 = [0,0];
outputRightSPN = [0,0];
outputRightSPN2 = [0,0];


%perform Left SPN Operation
    if inputLeftSPN == [1, 1]
            outputLeftSPN = [1, 0];

    elseif inputLeftSPN == [1, 0]
            outputLeftSPN = [0,0];

    elseif inputLeftSPN == [0, 0]
            outputLeftSPN = [1,1];
    else 
            outputLeftSPN = [0,1];
    end
    
%perform Right SPN Operation
    if inputRightSPN == [1, 1]
            outputRightSPN = [1, 0];

    elseif inputRightSPN == [1, 0]
            outputRightSPN = [0,0];

    elseif inputRightSPN == [0, 0]
            outputRightSPN = [1,1];
    else 
            outputRightSPN = [0,1];
    end
    

%swap sbox positions
[outputLeftSPN(1,2), outputRightSPN(1,2)] = deal(outputRightSPN(1,2),outputLeftSPN(1,2));


%combine 2 arrays and do second XOR operation with Key2
afterSPN1 = horzcat(outputLeftSPN,outputRightSPN);
afterKey2 = xor(afterSPN1,key2Array);

%split into halves again
inputLeftSPN2 = afterKey2(1,1:2);
inputRightSPN2 = afterKey2(1,3:4);


%perform second round Left SPN Operation
    if inputLeftSPN2 == [1, 1]
            outputLeftSPN2 = [1, 0];

    elseif inputLeftSPN2 == [1, 0]
            outputLeftSPN2 = [0,0];

    elseif inputLeftSPN2 == [0, 0]
            outputLeftSPN2 = [1,1];
    else 
            outputLeftSPN2 = [0,1];
    end
    
%perform second round Right SPN Operation
    if inputRightSPN2 == [1, 1]
            outputRightSPN2 = [1, 0];

    elseif inputRightSPN2 == [1, 0]
            outputRightSPN2 = [0,0];

    elseif inputRightSPN2 == [0, 0]
            outputRightSPN2 = [1,1];
    else 
            outputRightSPN2 = [0,1];
    end

%combine 2 arrays and do last XOR operation with Key3
afterSPN2 = horzcat(outputLeftSPN2,outputRightSPN2);
afterKey2 = xor(afterSPN2,key3Array);
cipherText = afterKey2;

%convert Ciphertext back to a decimal base number
convertCipher = num2str(cipherText,'%i');

%output display
disp('iteration') 
disp(n)
cipherOutput = bin2dec(convertCipher)

end

