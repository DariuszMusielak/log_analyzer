# log_analyzer

A small library for analyzing log files.

### Project setup
```bash
bundle exec bin/setup
```

### Usage

#### To run script use:
```bash
ruby bin/parse file_path
```

You can decide which of analyze you want to run by passing optional argument to script like this:
```bash
ruby bin/parse file_path optional_argument
```

|Field|Type|Description|
|-|-|-|
|file_path|String|Path to a file to be analysed|
|optional_argument|String|It is a analyze type, by defaut set to 'all', other options are: 'views' and 'uniq_views'|

You can run example on your own following these steps:

1. Clone repozitory
2. Open repozitory directory
3. Execute
```bash
ruby bin/setup
```
4. Get a path to [real data](https://github.com/DariuszMusielak/log_analyzer/blob/master/data/webserver.log) or to [test data](https://github.com/DariuszMusielak/log_analyzer/blob/master/spec/fixtures/webserver_short.log) on your local machine and use it as a path_file in a script below:

```bash
ruby bin/parse file_path
```

For data:
```
/test_page_1/1 111.222.333.444
/test_page_1/1 999.888.777.666
/test_page_2 999.888.777.666
/test_page_2 999.888.777.666
/test_page_2 111.222.333.444
```

Result looks like this:
```
----- Statistics for visits ----
/test_page_2 - 3 visits
/test_page_1/1 - 2 visits
----- Statistics for unique visits ----
/test_page_2 - 2 unique visits
/test_page_1/1 - 2 unique visits
```

### To run console use:
```bash
ruby bin/console
```

### Lints and fixes files
```bash
rubocop
```
add `-a` if you want autocorrection

### Run specs
```bash
bundle exec rspec
```
