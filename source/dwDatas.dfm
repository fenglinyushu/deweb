object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 529
  Top = 170
  Height = 335
  Width = 405
  object ADOConnection_Driver: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=drive' +
      'r.mdb;Mode=Share Deny None;Persist Security Info=False;Jet OLEDB' +
      ':System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Databas' +
      'e Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking' +
      ' Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bul' +
      'k Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Cr' +
      'eate System Database=False;Jet OLEDB:Encrypt Database=False;Jet ' +
      'OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Witho' +
      'ut Replica Repair=False;Jet OLEDB:SFP=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 48
    Top = 56
  end
  object ADOQuery_Driver: TADOQuery
    Connection = ADOConnection_Driver
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT Top 40 * FROM QuestionBank')
    Left = 48
    Top = 120
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection_Driver
    TableName = 'QuestionBank'
    Left = 48
    Top = 192
  end
  object ZConnection: TZConnection
    Protocol = 'sqlite-3'
    Port = 3306
    Database = 'deweb.db'
    Connected = True
    Left = 184
    Top = 56
  end
end
