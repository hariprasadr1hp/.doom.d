"""
converts rss.yml to elfeed-links.el
"""
import os
import sys
import yaml


def loadRSSdata(yml_file):
    with open(yml_file, 'r') as f:
        content = yaml.load(f, yaml.FullLoader)
    return content

def dump2URLS(urlfile, content):
    with open(urlfile, 'w') as g:
        newsfeeds   = content['newsfeeds']
        youtube     = content['youtube']
        reddit      = content['reddit']
        # github      = content['github']
        # gitlab      = content['gitlab']
        # bitbucket   = content['bitbucket']

        g.write(";;; modes/elfeed-mode/+elfeed-links.el -*- lexical-binding: t; -*-\n")
        g.write("\n")
        g.write("(setq elfeed-feeds\n")
        g.write("  '(\n")
        g.write("    ;; NEWSFEEDS\n")
        for link, title in newsfeeds.items():
            g.write('    ("{}")\n'.format(link))
        g.write("\n")

        g.write("    ;; YOUTUBE\n")
        for link, title in youtube.items():
            g.write('    ("https://www.youtube.com/feeds/videos.xml?channel_id={}" youtube)\n'.format(link))
        g.write("\n")
        
        g.write("    ;; REDDIT\n")
        for feed in reddit:
            g.write('    ("https://www.reddit.com/r/{}.rss" reddit)\n'.format(feed))
        g.write("\n")

        g.write("  ))\n")
        

def main(yml_file):
    content = loadRSSdata(yml_file)
    urlfile = os.path.join(os.environ['HOME'], '.doom.d/modes/elfeed-mode/+elfeed-links.el') 
    dump2URLS(urlfile, content)


if __name__ == "__main__":
    if len(sys.argv) == 1:
        yml_file = "rss.yml"
    elif len(sys.argv) == 2:
        yml_file = sys.argv[1]    
    else:
        print("Invalid number of arguments")
        exit(1)
    main(yml_file)
