import sublime, sublime_plugin, subprocess
 
class PrettifyJsonCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    command = 'python -mjson.tool'
 
    # help from http://www.sublimetext.com/forum/viewtopic.php?f=2&p=12451
    p = subprocess.Popen(command, bufsize=-1, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE, shell=True)
    result, err = p.communicate(self.view.substr(self.view.sel()[0]).encode('utf-8'))
 
    # gave up trying this approach: result always has '\n' strings in it that refuse to render
    #result = json.dumps( self.view.substr(self.view.sel()[0]), indent=2)
 
    # http://code.activestate.com/recipes/65211/  seems to say that Python "ruins" non-raw strings by 
    # actually placing '\','n' in the friggin string unless it's marked 'raw'?  Is that true?  Shouldn't a string be a string
    # and the raw/not raw output be a function of the runtime?  Why does "print" have some magic to reescape these strings and
    # yet there are no other buffer objects that seem to do it (aka StringIO or BytesIO).
 
    if result != "":
      self.view.replace(edit, self.view.sel()[0], result.decode('utf-8'))
      sublime.set_timeout(self.clear,0)
    else:
      self.view.set_status('tidyjson', "tidyjson: "+err)
      sublime.set_timeout(self.clear,10000)
    
 
  def clear(self):
    self.view.erase_status('tidyjson')
