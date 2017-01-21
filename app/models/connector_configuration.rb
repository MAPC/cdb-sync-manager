class ConnectorConfiguration < ActiveRecord::Base
  def get_table_names
      conn = PGconn.open(
        host: server,
        user: username,
        password: password,
        dbname: database
      )

      res = conn.exec('select * from information_schema.tables')
      structured = []
      res.each do |row|
        structured.push row['table_name']
      end
      structured
  end
end
