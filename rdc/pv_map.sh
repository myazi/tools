"""
query_pv
"""
import sys
import json

for line in sys.stdin:
    try:
        data = json.loads(line.strip(), encoding='gb18030')
    except:
        #print >>sys.stderr, line.strip()
        continue
    if 'se_li' not in data:
        #print >>sys.stderr, line.strip()
        continue
    info = data['se_li'][0]
    if 'query' not in info or 'qu_l1' not in info:
        #print >>sys.stderr, line.strip()
        continue
    query = info['query'].encode('gb18030')
    qc = info['qu_l1'].encode('gb18030')
    print(query + "\t" + qc)

