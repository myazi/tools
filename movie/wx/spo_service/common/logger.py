#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
logger

"""

import logging
import logging.handlers

class Logger(object):
    """
    @summary: 日志打印类
    - 日志格式为:
    - [%(levelname)s] [%(asctime)s] [THREAD:%(threadName)s] [MODULE:%(module)s] [line:%(lineno)s] [%(message)s]
    - Usage:
    -----------------------------------------------------------
    - logger = Logger('logfile', 'logname')
    - logger.debug  ("...") 
    - logger.info   ("....") 
    - logger.warning(".....") 
    - logger.error  ("......") 
    - logger.fatal  (".......") 
    -----------------------------------------------------------
    -levelname: debug -> info -> warning -> error -> fatal
    -----------------------------------------------------------
    """
    logger = None
    def __new__(cls, logfile='TestService.log', logname='TestService'):
        if Logger.logger is None:
            Logger.logger = logging.getLogger(logname)
            LOGS_FORMAT = '[%(levelname)s] [%(asctime)s] [THREAD:%(threadName)s] ' + \
                '[MODULE:%(module)s] [line:%(lineno)s] [%(message)s]'
            DATE_FORMAT   = '%Y-%m-%d %H:%M:%S'
            fhandler      = logging.handlers.TimedRotatingFileHandler(logfile, 'D', 1, 31)
            formatter      = logging.Formatter(LOGS_FORMAT, datefmt = DATE_FORMAT)
            fhandler.setFormatter(formatter)
            fhandler.suffix = "%Y%m%d"
            Logger.logger.addHandler(fhandler)
            Logger.logger.setLevel(logging.DEBUG)
        
        return Logger.logger

    def __init__(self):
        pass
    
    @staticmethod
    def getInstance():
        """
        @summary: 获取实例
        """
        return Logger.logger    
        
if '__main__' == __name__:
    logger_dict = {}
    for index in range(0, 2):
        logger = Logger('test.log', 'test')
        logger_dict[index] = logger
    
    for index in range(0, 2):
        logger_dict[index].debug('1111111')
        logger_dict[index].info('1111111')
        logger_dict[index].warning('1111111')
        logger_dict[index].error('1111111')
        logger_dict[index].fatal('1111111')
    
