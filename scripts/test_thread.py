#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import time
from queue import Queue, Empty
from threading import Thread
import concurrent.futures

def worker(ip):
    start_time = time.time()
    time.sleep(1)
    end_time = time.time()
    use_time = end_time - start_time
    #print(str(ip) + "\t" + str(use_time))

def test1(ips):
    start_time = time.time()
    threads = [
        Thread(target=worker, args=(ip, )) for ip in ips
    ]
    for thread in threads:
        thread.start()

    for thread in threads:
        thread.join()
    end_time = time.time()
    
    print("test1 all time: " + str(end_time - start_time))

def test2(ips):
    start_time = time.time()
    with concurrent.futures.ThreadPoolExecutor(max_workers=1000) as executor:
        futures = [executor.submit(worker, ip) for ip in ips]
        for future in concurrent.futures.as_completed(futures):
            try:
                future.result()
            except Exception as e:
                print(f'Exception: {e}')
    end_time = time.time()
    
    print("test2 all time: " + str(end_time - start_time))

def worker2(work_queue):
    while not work_queue.empty():
        try:
            ip = work_queue.get(block=False)
        except Empty:
            break
        else:
            try:
                start_time = time.time()
                time.sleep(1)
                end_time = time.time()
                use_time = end_time - start_time
                #print(str(ip) + "\t" + str(use_time))
            except:
                print("error ip is " + "\t" + str(ip))
            finally:
                work_queue.task_done()

def test3(ips):
    work_queue = Queue()
    for ip in ips:
        work_queue.put(ip)

    start_time = time.time()

    threads = [
        Thread(target=worker2, args=(work_queue, )) for _ in range(1000)
    ]
    
    for thread in threads:
        thread.start()

    work_queue.join()

    while threads:
        threads.pop().join()

    end_time = time.time()
    print("test3 all time: " + str(end_time - start_time))

def mid_worker(work_queue):
    
    threads = [Thread(target=worker2, args=(work_queue, )) for _ in range(30)]

    for thread in threads:
        thread.start()

    work_queue.join()

    while threads:
        threads.pop().join()

def test4(ips):
    work_queue = Queue()
    for ip in ips:
        work_queue.put(ip)

    start_time = time.time()

    threads = [
        Thread(target=mid_worker, args=(work_queue, )) for _ in range(40)
    ]
    
    for thread in threads:
        thread.start()

    work_queue.join()

    while threads:
        threads.pop().join()

    end_time = time.time()
    print("test4 all time: " + str(end_time - start_time))


if __name__ == '__main__':
    ips = [_ for _ in range(1000)]
    test1(ips)
    test2(ips)
    test3(ips)
    test4(ips)
    # test5 通过起多个进程，然后再起一个进程，以多线程方式请求预先启动的多个进程
