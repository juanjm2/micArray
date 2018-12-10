#include "AudioFile.h"
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <locale>
#include <algorithm>
#include <vector>
using namespace std;

const int INT24_MAX = 8388607;

class Int24
{
protected:
    unsigned char m_Internal[3];
public:
    Int24()
    {
    }

    Int24( const int val )
    {
        *this   = val;
    }

    Int24( const Int24& val )
    {
        *this   = val;
    }

    operator int() const
    {
        if ( m_Internal[2] & 0x80 ) // Is this a negative?  Then we need to siingn extend.
        {
            return (0xff << 24) | (m_Internal[2] << 16) | (m_Internal[1] << 8) | (m_Internal[0] << 0);
        }
        else
        {
            return (m_Internal[2] << 16) | (m_Internal[1] << 8) | (m_Internal[0] << 0);
        }
    }

    operator float() const
    {
        return (float)this->operator int();
    }

    Int24& operator =( const Int24& input )
    {
        m_Internal[0]   = input.m_Internal[0];
        m_Internal[1]   = input.m_Internal[1];
        m_Internal[2]   = input.m_Internal[2];

        return *this;
    }

    Int24& operator =( const int input )
    {
        m_Internal[0]   = ((unsigned char*)&input)[0];
        m_Internal[1]   = ((unsigned char*)&input)[1];
        m_Internal[2]   = ((unsigned char*)&input)[2];

        return *this;
    }

    /***********************************************/

    Int24 operator +( const Int24& val ) const
    {
        return Int24( (int)*this + (int)val );
    }

    Int24 operator -( const Int24& val ) const
    {
        return Int24( (int)*this - (int)val );
    }

    Int24 operator *( const Int24& val ) const
    {
        return Int24( (int)*this * (int)val );
    }

    Int24 operator /( const Int24& val ) const
    {
        return Int24( (int)*this / (int)val );
    }

    /***********************************************/

    Int24 operator +( const int val ) const
    {
        return Int24( (int)*this + val );
    }

    Int24 operator -( const int val ) const
    {
        return Int24( (int)*this - val );
    }

    Int24 operator *( const int val ) const
    {
        return Int24( (int)*this * val );
    }

    Int24 operator /( const int val ) const
    {
        return Int24( (int)*this / val );
    }

    /***********************************************/
    /***********************************************/


    Int24& operator +=( const Int24& val )
    {
        *this   = *this + val;
        return *this;
    }

    Int24& operator -=( const Int24& val )
    {
        *this   = *this - val;
        return *this;
    }

    Int24& operator *=( const Int24& val )
    {
        *this   = *this * val;
        return *this;
    }

    Int24& operator /=( const Int24& val )
    {
        *this   = *this / val;
        return *this;
    }

    /***********************************************/

    Int24& operator +=( const int val )
    {
        *this   = *this + val;
        return *this;
    }

    Int24& operator -=( const int val )
    {
        *this   = *this - val;
        return *this;
    }

    Int24& operator *=( const int val )
    {
        *this   = *this * val;
        return *this;
    }

    Int24& operator /=( const int val )
    {
        *this   = *this / val;
        return *this;
    }

    /***********************************************/
    /***********************************************/

    Int24 operator >>( const int val ) const
    {
        return Int24( (int)*this >> val );
    }

    Int24 operator <<( const int val ) const
    {
        return Int24( (int)*this << val );
    }

    /***********************************************/

    Int24& operator >>=( const int val )
    {
        *this = *this >> val;
        return *this;
    }

    Int24& operator <<=( const int val )
    {
        *this = *this << val;
        return *this;
    }

    /***********************************************/
    /***********************************************/

    operator bool() const
    {
        return (int)*this != 0;
    }

    bool operator !() const
    {
        return !((int)*this);
    }

    Int24 operator -()
    {
        return Int24( -(int)*this );
    }

    /***********************************************/
    /***********************************************/

    bool operator ==( const Int24& val ) const
    {
        return (int)*this == (int)val;
    }

    bool operator !=( const Int24& val ) const
    {
        return (int)*this != (int)val;
    }

    bool operator >=( const Int24& val ) const
    {
        return (int)*this >= (int)val;
    }

    bool operator <=( const Int24& val ) const
    {
        return (int)*this <= (int)val;
    }

    bool operator >( const Int24& val ) const
    {
        return (int)*this > (int)val;
    }

    bool operator <( const Int24& val ) const
    {
        return (int)*this < (int)val;
    }

    /***********************************************/

    bool operator ==( const int val ) const
    {
        return (int)*this == val;
    }

    bool operator !=( const int val ) const
    {
        return (int)*this != val;
    }

    bool operator >=( const int val ) const
    {
        return (int)*this >= val;
    }

    bool operator <=( const int val ) const
    {
        return (int)*this <= val;
    }

    bool operator >( const int val ) const
    {
        return ((int)*this) > val;
    }

    bool operator <( const int val ) const
    {
        return (int)*this < val;
    }

    /***********************************************/
    /***********************************************/
};

int main(){
    string data;
    string testf;
    stringstream ss;
	Int24 sample; 
	unsigned int x;
	double samp24;
	AudioFile<double>::AudioBuffer buffer;
	buffer.resize(2);

    AudioFile<double> audioFile, fir;
    //audioFile.load("H:/juanjm2_git/micArray/Working_Code/out5.wav");
	//audioFile.printSummary();
    uint32_t he = 0xF3853758;
    printf("%lX\n", he);
    printf("%d\n", he);
   	fir.load("H:/juanjm2_git/micArray/Working_Code/out2.wav");
	fir.printSummary();

	ifstream inf("H:/juanjm2_git/micArray/Working_Code/AudioFile-master/AudioFile-master/OUT3.dat");
	if (!inf)
	{
		cerr << "Error opening file" << endl;
		exit(1);
	}

	buffer[0].resize(720000);
	buffer[1].resize(720000);

	for(int i = 0; i < 720000; i++)
	{
		getline(inf, data);
		testf = "0x";
		testf = testf + data;
		transform(testf.begin(), testf.end(), testf.begin(), ::tolower);
		//cout << testf << ":		";
		ss << std::hex << testf;
		ss >> x;
		sample = x;
		samp24 = int(sample);
		if (samp24 >= 0)
		{
			buffer[0][i] = (samp24 / (double)8388607);
		}
		else
		{
			buffer[0][i] = (samp24 / (double)8388608);
		}
		ss.clear();
	}
	
	inf.close();

	ifstream inf2("H:/juanjm2_git/micArray/Working_Code/AudioFile-master/AudioFile-master/OUT4.dat");
	if (!inf2)
	{
		cerr << "Error opening file" << endl;
		exit(1);
	}


	for(int i = 0; i < 720000; i++)
	{
		getline(inf2, data);
		testf = "0x";
		testf = testf + data;
		transform(testf.begin(), testf.end(), testf.begin(), ::tolower);
		//cout << testf << ":		";
		ss << std::hex << testf;
		ss >> x;
		sample = x;
		samp24 = int(sample);
		if (samp24 >= 0)
		{
			buffer[1][i] = (samp24 / (double)8388607);
		}
		else
		{
			buffer[1][i] = (samp24 / (double)8388608);
		}
		ss.clear();
	}
	
	// cout << "Size : " << buffer[1].size(); 
    // cout << "\nCapacity : " << buffer[1].capacity(); 
    // cout << "\nMax_Size : " << buffer[1].max_size(); 

    // if (buffer[1].empty() == false) 
    //     cout << "\nVector is not empty"; 
    // else
    //     cout << "\nVector is empty"; 

	inf2.close();

	bool ok = fir.setAudioBuffer(buffer);
	cout << ok << endl;
	fir.setAudioBufferSize(2, 720000);
	fir.setNumSamplesPerChannel(720000);
	fir.setNumChannels(2);
	fir.setBitDepth(24);
	fir.setSampleRate(48000);

	fir.save("H:/juanjm2_git/micArray/Working_Code/AudioFile-master/AudioFile-master/fir_wav_c.wav");
	cout << buffer[1][29] << endl;
	fir.printSummary();

    return 0;
}