CXX=clang++
CXXFLAGS=-g -std=c++11 -Wall -pedantic
DEPS = AudioFile.h
OBJ = test_wav.o

%.o: %.c $(DEPS)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

go: $(OBJ)
	gcc $(CXXFLAGS) -o $@ $^