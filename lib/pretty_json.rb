def pretty_json(path, lang, indent="")
    data = JSON.parse(File.read("source/json/#{path}.json"))
    case lang
    when "json"
        JSON.pretty_generate(data)
    when "python"
        pretty_json_python(data)
    when "javascript"
        pretty_json_javascript(data)
    end.gsub("\n", "\n#{indent}")
end

def pretty_json_python(data)
    indent = "    "

    case data
    when nil
        "None"
    when true
        "True"
    when false
        "False"
    when Array
        "[\n#{indent}" + data.map{|a| pretty_json_python(a)}.join(",\n").gsub("\n", "\n#{indent}") + "\n]"
    when Hash
        "{\n#{indent}" + data.map{|k, v| JSON.pretty_generate(k) + ": " + pretty_json_python(v)}.join(",\n").gsub("\n", "\n#{indent}") + "\n}"
    else
        JSON.pretty_generate(data)
    end
end

def pretty_json_javascript(data)
    indent = "    "

    case data
    when String
        "'" + data.gsub("\\", "\\\\").gsub("'", "\\'").gsub("\n", "\\n'") + "'"
    when Array
        "[\n#{indent}" + data.map{|a| pretty_json_javascript(a)}.join(",\n").gsub("\n", "\n#{indent}") + "\n]"
    when Hash
        "{\n#{indent}" + data.map{|k, v| k + ": " + pretty_json_javascript(v)}.join(",\n").gsub("\n", "\n#{indent}") + "\n}"
    else
        JSON.pretty_generate(data)
    end
end
