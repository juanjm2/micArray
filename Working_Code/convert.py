from scipy.io.wavfile import write
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy.io import wavfile

# https://stackoverflow.com/questions/11798800/reading-a-binary-dat-file-as-an-array
# https://www.geeksforgeeks.org/reverse-bits-positive-integer-number-python/

def reverseBits(num,bitSize=32):
 
     # convert number into binary representation
     # output will be like bin(10) = '0b10101'
     binary = bin(num)
 
     # skip first two characters of binary
     # representation string and reverse
     # remaining string and then append zeros
     # after it. binary[-1:1:-1]  --> start
     # from last character and reverse it until
     # second last character from left
     reverse = binary[-1:1:-1]
     reverse = reverse + (bitSize - len(reverse))*'0'
     reverse = int(reverse,2)
     reverse = reverse >> 16
     # converts reversed binary string into integer
     return reverse




F = open("OUT.dat","r")

data_l = []
data_r = []
#data.append([])
#data.append([])
#right = []

for line in F:
#	data[0].append(0xffff&int(line.split()[0],16))
#	data[1].append(0xffff&int(line.split()[1],16))
	l_sample = int(line.split()[0],16)
	r_sample = int(line.split()[1],16)
	#sample = reverseBits(sample)
	data_l.append(l_sample)
	data_r.append(r_sample)
	#print (sample)
	#data.append(0xffff&int(line.split()[1],16))
F.close()

data_l = np.asarray(data_l, dtype = np.int16)
data_r = np.asarray(data_r, dtype = np.int16)
print(data_l.shape)
print(data_r.shape)
#data_l = np.transpose(data_l)
#data_r = np.transpose(data_r)
#print(data_l.shape)
#print(data_r.shape)

data = np.stack((data_l,data_r))
data = np.transpose(data)
print(data.shape)

#t = np.arange(data.shape[0])/882000
#plt.plot(t,data[:])
#plt.show()

#data = np.fromfile('OUT.dat',dtype= 'int16',sep=' ')
#data_o = np.zeros( (int(x/2), 2))
#for i in range(data.shape[0]):
#	if i%2 == 0:
#		data_o[int(i/2)][0] = data[i]
#	if i%2 == 1:
#		data_o[int(i/2)][0] = data[i]
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.io.wavfile.write.html
write('out.wav', 48000, data)

F = open("OUT2.dat","r")

data_l = []
data_r = []
#data.append([])
#data.append([])
#right = []

for line in F:
#	data[0].append(0xffff&int(line.split()[0],16))
#	data[1].append(0xffff&int(line.split()[1],16))
	l_sample = int(line.split()[0],16)
	r_sample = int(line.split()[1],16)
	#sample = reverseBits(sample)
	data_l.append(l_sample)
	data_r.append(r_sample)
	#print (sample)
	#data.append(0xffff&int(line.split()[1],16))
F.close()

data_l = np.asarray(data_l, dtype = np.int16)
data_r = np.asarray(data_r, dtype = np.int16)
print(data_l.shape)
print(data_r.shape)
#data_l = np.transpose(data_l)
#data_r = np.transpose(data_r)
#print(data_l.shape)
#print(data_r.shape)

data = np.stack((data_l,data_r))
data = np.transpose(data)
print(data.shape)

#t = np.arange(data.shape[0])/882000
#plt.plot(t,data[:])
#plt.show()

#data = np.fromfile('OUT.dat',dtype= 'int16',sep=' ')
#data_o = np.zeros( (int(x/2), 2))
#for i in range(data.shape[0]):
#	if i%2 == 0:
#		data_o[int(i/2)][0] = data[i]
#	if i%2 == 1:
#		data_o[int(i/2)][0] = data[i]
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.io.wavfile.write.html
write('out2.wav', 48000, data)

F = open("OUT3.dat","r")

data_l = []
data_r = []
#data.append([])
#data.append([])
#right = []

for line in F:
#	data[0].append(0xffff&int(line.split()[0],16))
#	data[1].append(0xffff&int(line.split()[1],16))
	l_sample = int(line.split()[0],16)
	r_sample = int(line.split()[1],16)
	#sample = reverseBits(sample)
	data_l.append(l_sample)
	data_r.append(r_sample)
	#print (sample)
	#data.append(0xffff&int(line.split()[1],16))
F.close()

data_l = np.asarray(data_l, dtype = np.int16)
data_r = np.asarray(data_r, dtype = np.int16)
print(data_l.shape)
print(data_r.shape)
#data_l = np.transpose(data_l)
#data_r = np.transpose(data_r)
#print(data_l.shape)
#print(data_r.shape)

data = np.stack((data_l,data_r))
data = np.transpose(data)
print(data.shape)

#t = np.arange(data.shape[0])/882000
#plt.plot(t,data[:])
#plt.show()

#data = np.fromfile('OUT.dat',dtype= 'int16',sep=' ')
#data_o = np.zeros( (int(x/2), 2))
#for i in range(data.shape[0]):
#	if i%2 == 0:
#		data_o[int(i/2)][0] = data[i]
#	if i%2 == 1:
#		data_o[int(i/2)][0] = data[i]
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.io.wavfile.write.html
write('out3.wav', 48000, data)

F = open("OUT4.dat","r")

data_l = []
data_r = []
#data.append([])
#data.append([])
#right = []

for line in F:
#	data[0].append(0xffff&int(line.split()[0],16))
#	data[1].append(0xffff&int(line.split()[1],16))
	l_sample = int(line.split()[0],16)
	r_sample = int(line.split()[1],16)
	#sample = reverseBits(sample)
	data_l.append(l_sample)
	data_r.append(r_sample)
	#print (sample)
	#data.append(0xffff&int(line.split()[1],16))
F.close()

data_l = np.asarray(data_l, dtype = np.int16)
data_r = np.asarray(data_r, dtype = np.int16)
print(data_l.shape)
print(data_r.shape)
#data_l = np.transpose(data_l)
#data_r = np.transpose(data_r)
#print(data_l.shape)
#print(data_r.shape)

data = np.stack((data_l,data_r))
data = np.transpose(data)
print(data.shape)

#t = np.arange(data.shape[0])/882000
#plt.plot(t,data[:])
#plt.show()

#data = np.fromfile('OUT.dat',dtype= 'int16',sep=' ')
#data_o = np.zeros( (int(x/2), 2))
#for i in range(data.shape[0]):
#	if i%2 == 0:
#		data_o[int(i/2)][0] = data[i]
#	if i%2 == 1:
#		data_o[int(i/2)][0] = data[i]
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.io.wavfile.write.html
write('out4.wav', 48000, data)

F = open("OUT5.dat","r")

data_l = []
data_r = []
#data.append([])
#data.append([])
#right = []

for line in F:
#	data[0].append(0xffff&int(line.split()[0],16))
#	data[1].append(0xffff&int(line.split()[1],16))
	l_sample = int(line.split()[0],16)
	r_sample = int(line.split()[1],16)
	#sample = reverseBits(sample)
	data_l.append(l_sample)
	data_r.append(r_sample)
	#print (sample)
	#data.append(0xffff&int(line.split()[1],16))
F.close()

data_l = np.asarray(data_l, dtype = np.int16)
data_r = np.asarray(data_r, dtype = np.int16)
print(data_l.shape)
print(data_r.shape)
#data_l = np.transpose(data_l)
#data_r = np.transpose(data_r)
#print(data_l.shape)
#print(data_r.shape)

data = np.stack((data_l,data_r))
data = np.transpose(data)
print(data.shape)

#t = np.arange(data.shape[0])/882000
#plt.plot(t,data[:])
#plt.show()

#data = np.fromfile('OUT.dat',dtype= 'int16',sep=' ')
#data_o = np.zeros( (int(x/2), 2))
#for i in range(data.shape[0]):
#	if i%2 == 0:
#		data_o[int(i/2)][0] = data[i]
#	if i%2 == 1:
#		data_o[int(i/2)][0] = data[i]
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.io.wavfile.write.html
write('out5.wav', 48000, data)