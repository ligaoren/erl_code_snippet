-spec url_encode(string() | binary() | integer() | float() | atom()) -> string().
url_encode(String) ->
    ibrowse_lib:url_encode(to_string(String)).
