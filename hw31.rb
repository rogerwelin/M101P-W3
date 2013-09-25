#!/usr/bin/env ruby

require 'mongo'
include Mongo

conn = MongoClient.new("localhost", 27017).db("school")
students = conn.collection("students")

#query = {"_id" => 1}

def remove_lowest_score(conn, students)
  begin
    cursor = students.find()
    for doc in cursor
      low_fucker = 666.6 
      for score in doc['scores']
        if score['type'] == "homework"
          low = score['score']
          if low < low_fucker
            low_fucker = low
          end
        end
      end
      puts "I will remove this score:  #{low_fucker}"
      doc['scores'].delete({'type' => 'homework','score' => low_fucker})
      students.update({'_id' => doc['_id']},{'$set' => {'scores' => doc['scores']}})
    end
  rescue Exception => e 
    puts e
    exit
  end 
end

remove_lowest_score(conn, students)


