# 无法处理含义符号& 的url, ( 应该在shell解析时(还没进python) 就不行, )
import os
import sys
quote_url_quote = "'" + sys.argv[1] + "'"
os.system("axel {}".format(quote_url_quote))
print('axel 搞定')
