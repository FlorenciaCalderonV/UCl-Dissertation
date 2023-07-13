a = arduino();

for i = 1:5
    writeDigitalPin(a, 'D10', 1);
    pause(0.5);
    writeDigitalPin(a,'D13', 1);
    pause(0.5);
    writeDigitalPin(a,'D11', 1);
    pause(0.5);
    writeDigitalPin(a,'D12', 1);
    pause(0.5);
    
    writeDigitalPin(a, 'D10', 0);
    writeDigitalPin(a,'D13', 0);
    writeDigitalPin(a,'D11', 0);
    writeDigitalPin(a,'D12', 0);
    
end

