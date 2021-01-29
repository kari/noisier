//
//  NoiseGenerator.swift
//  noisier
//
//  Created by Kari Silvennoinen on 08.07.2018.
//  Copyright © 2018 Kalifi.org. All rights reserved.
//
/*
import Foundation
import AudioToolbox

class NoiseGenerator {
    var noiseSource = PinkNoise.init(numRows: 5)
    var isPlaying = false
    private var queue: AudioQueueRef? = nil {
        didSet {
            oldValue.map {
                AudioQueueStop($0, true)
                AudioQueueDispose($0, true)
            }
        }
    }
    let kNumberOfBuffers = 2
    let kBytesPerBuffer = 2*8*1024
    var buffers = [AudioQueueBufferRef]()
    private var outputCallback: AudioQueueOutputCallback = {(
        inUserData: UnsafeMutableRawPointer?,
        inAQ: AudioQueueRef,
        inBuffer: AudioQueueBufferRef) -> Void in
        // FILLME
    }
    
    init(numRows: Int) {
        self.noiseSource = PinkNoise(numRows: numRows)
    }
    
    func startAudio() {
        if (!self.isPlaying) {
            var description = AudioStreamBasicDescription.init(mSampleRate: 44100, mFormatID: kAudioFormatLinearPCM, mFormatFlags: kAudioFormatFlagIsFloat, mBytesPerPacket: UInt32(MemoryLayout<Float>.size), mFramesPerPacket: 1, mBytesPerFrame: UInt32(MemoryLayout<Float>.size), mChannelsPerFrame: 1, mBitsPerChannel: UInt32(MemoryLayout<Float>.size * 8), mReserved: 0)
            self.isPlaying = true
            var status: OSStatus = 0
            let selfPointer = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
            status = AudioQueueNewOutput(&description, self.outputCallback, selfPointer, CFRunLoopGetCurrent(), CFRunLoopMode.commonModes.rawValue, 0, &self.queue)
            assert(noErr == status)
            for _ in 0..<kNumberOfBuffers {
                var buffer: AudioQueueBufferRef? = nil
                status = AudioQueueAllocateBuffer(self.queue!, UInt32(kBytesPerBuffer), &buffer)
                if let buffer: AudioQueueBufferRef = buffer {
                    buffers.append(buffer)
                }
                processBuffer(bufferRef: buffer!)
            }
            status = AudioQueueStart(self.queue!, nil)
        }
    }
    
    func processBuffer(bufferRef: AudioQueueBufferRef) {
        let audioQueueBuffer = bufferRef.pointee
        let bufferSize = audioQueueBuffer.mAudioDataBytesCapacity
        let bufferFrames = Int(bufferSize) / MemoryLayout<Float>.size
        var buffer = audioQueueBuffer.mAudioData
        var sample: Float
        
        for i in 0..<bufferFrames {
            buffer = noiseSource.generate()
        }
        audioQueueBuffer.mAudioDataByteSize = (i * MemoryLayout<Float>.size)
        AudioQueueEnqueueBuffer(self.queue!, bufferRef, 0, nil)
    }
}
*/
