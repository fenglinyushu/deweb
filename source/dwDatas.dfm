object DM: TDM
  OldCreateOrder = False
  Left = 192
  Top = 131
  Height = 342
  Width = 405
  object ADOConnection_Driver: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\'#25105#30340#24037#20316'\deweb2020\s' +
      'ource\Runtime\driver.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 48
    Top = 56
  end
  object ADOQuery_Driver: TADOQuery
    Active = True
    Connection = ADOConnection_Driver
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM QuestionBank')
    Left = 48
    Top = 120
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection_Driver
    TableName = 'QuestionBank'
    Left = 56
    Top = 192
  end
end
