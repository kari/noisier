//
//  NoiseRenderer.swift
//  noisier
//
//  Created by Kari Silvennoinen on 09.07.2018.
//  Copyright © 2018 Kalifi.org. All rights reserved.
//

import Foundation
import AudioToolbox

var pink = PinkNoise.init(numRows: 5)

func RenderNoise(inRefCon: UnsafeMutableRawPointer, ioActionFlags: UnsafeMutablePointer<AudioUnitRenderActionFlags>, inTimeStamp: UnsafePointer<AudioTimeStamp>, inBusNumber: UInt32, inNumberFrames: UInt32, ioData: UnsafeMutablePointer<AudioBufferList>?) -> OSStatus {
    
    // let amplitude = 0.25
    let channel = 0
    let bufferList = UnsafeMutableAudioBufferListPointer(ioData)
    guard let buffer = bufferList?[channel].mData?.assumingMemoryBound(to: Float.self) else {
        assertionFailure("Could not access buffer")
        return -1
    }
    
    for frame in 0..<Int(inNumberFrames) {
        buffer[frame] = Float(pink.generate())
    }
    
    return noErr
}

class NoiseRenderer {
    var noiseUnit: AudioComponentInstance?

    init() {
        
    }
    
    func createNoiseUnit() {
        let selfPointer = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        var defaultOutputDescription = AudioComponentDescription.init(
                componentType: kAudioUnitType_Output,
                componentSubType: kAudioUnitSubType_DefaultOutput,
                componentManufacturer: kAudioUnitManufacturer_Apple,
                componentFlags: 0,
                componentFlagsMask: 0)
        var streamDescription = AudioStreamBasicDescription.init(
                mSampleRate: 44100,
                mFormatID: kAudioFormatLinearPCM,
                mFormatFlags: kAudioFormatFlagIsFloat,
                mBytesPerPacket: UInt32(MemoryLayout<Float>.size),
                mFramesPerPacket: 1,
                mBytesPerFrame: UInt32(MemoryLayout<Float>.size),
                mChannelsPerFrame: 1,
                mBitsPerChannel: UInt32(MemoryLayout<Float>.size * 8),
                mReserved: 0)
        guard let defaultOutput = AudioComponentFindNext(nil, &defaultOutputDescription) else {
            assertionFailure("Can't find default output")
            return
        }
        var err = AudioComponentInstanceNew(defaultOutput, &noiseUnit)
        guard let _ = noiseUnit else {
            assertionFailure("Error creating unit: \(err)")
            return
        }
        var input = AURenderCallbackStruct.init(
                inputProc: RenderNoise,
                inputProcRefCon: selfPointer)
        err = AudioUnitSetProperty(
                noiseUnit!,
                kAudioUnitProperty_SetRenderCallback,
                kAudioUnitScope_Input,
                0,
                &input,
                UInt32(MemoryLayout<AURenderCallbackStruct>.size))
        assert(err == noErr, "Error setting callback: \(err)")
        err = AudioUnitSetProperty(
                noiseUnit!,
                kAudioUnitProperty_StreamFormat,
                kAudioUnitScope_Input,
                0,
                &streamDescription,
                UInt32(MemoryLayout<AudioStreamBasicDescription>.size))
        assert(err == noErr, "Error setting stream format: \(err)")
    }
    
}
