<b># Python Task Part1</b><br>
<b># Solution</b><br>
"stack_wrapper.py" in "part1" fodler<br>
Short brief, that show what I use:<br>
	cloudformation templates for testing<br>
	subparsers. They allow using defaults parameters such as functions. But we can't use them with <a href="https://docs.python.org/3/library/argparse.html#parents">parent's parsers</a> (get heap of cli parameters)<br>
		for "--log" must use "getattr()" for setting log level to config, otherwise get error<br>
	help stdout. (if we don't use any cli parameter, we get error without that)<br>
	open_file function, which try open, read and then validate template file. If OK, close file and return it, otherwise get exception. <br>
	stack_exists function,which try get response from AWS if stack exists, otherwise exception. Needed for delete_stack function, which show us no error, if stack doesn't exists<br>
	set_waiter function, which try to create waiter and waite for AWS response, otherwise exception<br>
	create_stack function with parameters, which read valid template file and try to create stack with capabilities (hardcoded), otherwise exception. Then set waiter using set_waiter function<br>
	updade_stack function with parameters, which read valid template file and try to update stack with capabilities (hardcoded), otherwise exception. Then set waiter using set_waiter function<br>
	delete_stack function with parameters, which check if stack exists and try to delete stack, otherwise exception. Then set waiter using set_waiter function<br>
	main function as entry point, where we get arguments fom parsers, configure logging (if logfile argument exists, <a href="https://docs.python.org/3/howto/logging.html#logging-to-a-file">write log to file</a>)<br>
	if __name__ == '__main__', which run main function<br>
<b>Note</b>: Don't handle parameters for template (try to handle the in part2 of this task) and don't handle template file name, which can based on stack name (leave an opportunity of setting different names)  
