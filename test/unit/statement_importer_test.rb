require 'test_helper'

class StatementImporterTest < ActiveSupport::TestCase
  
  def setup
    StatementImporter.import(example_ofx)
  end
  
  def test_should_import_two_transactions
    assert_equal 2, Transaction.count
  end
  
  def test_should_import_the_first_transaction
    transaction = Transaction.find_by_fit_id('2011010112345678901234567890123')
    assert_equal Date.parse('2011-01-01'), transaction.original_date
    assert_equal 'other',                  transaction.type
    assert_equal -123,                     transaction.amount_in_pence
    assert_equal 'SHOP X',                 transaction.name
    assert_equal 'LONDON',                 transaction.memo
  end
  
  def test_should_import_the_second_transaction
    transaction = Transaction.find_by_fit_id('2011010212345678901234567890123')
    assert_equal Date.parse('2011-01-02'), transaction.original_date
    assert_equal 'other',                  transaction.type
    assert_equal 321,                      transaction.amount_in_pence
    assert_equal 'WAGES',                  transaction.name
    assert_equal 'ACME LTD',               transaction.memo
  end
  
  private
  
  def example_ofx
    <<-EndOfx
OFXHEADER:100
DATA:OFXSGML
VERSION:102
SECURITY:NONE
ENCODING:USASCII
CHARSET:1252
COMPRESSION:NONE
OLDFILEUID:NONE
NEWFILEUID:NONE

<OFX>
<SIGNONMSGSRSV1>
<SONRS>
<STATUS>
<CODE>0</CODE>
<SEVERITY>INFO</SEVERITY>
</STATUS>
<DTSERVER>20110102090000</DTSERVER>
<LANGUAGE>ENG</LANGUAGE>
<INTU.BID>01267
</SONRS>
</SIGNONMSGSRSV1>
<BANKMSGSRSV1>
<STMTTRNRS>
<TRNUID>1</TRNUID>
<STATUS>
<CODE>0</CODE>
<SEVERITY>INFO</SEVERITY>
</STATUS>
<STMTRS>
<CURDEF>GBP</CURDEF>
<BANKACCTFROM>
<BANKID>123456</BANKID>
<ACCTID>12341234123412</ACCTID>
<ACCTTYPE>CHECKING</ACCTTYPE>
</BANKACCTFROM>
<BANKTRANLIST>
<DTSTART>20110101000000</DTSTART>
<DTEND>20110102000000</DTEND>
<STMTTRN>
<TRNTYPE>OTHER</TRNTYPE>
<DTPOSTED>20110101000000</DTPOSTED>
<TRNAMT>-1.23</TRNAMT>
<FITID>2011010112345678901234567890123</FITID>
<NAME>SHOP X</NAME>
<MEMO>LONDON</MEMO>
</STMTTRN>
<STMTTRN>
<TRNTYPE>OTHER</TRNTYPE>
<DTPOSTED>20110102000000</DTPOSTED>
<TRNAMT>3.21</TRNAMT>
<FITID>2011010212345678901234567890123</FITID>
<NAME>WAGES</NAME>
<MEMO>ACME LTD</MEMO>
</STMTTRN>
</BANKTRANLIST>
<LEDGERBAL>
<BALAMT>0.00</BALAMT>
<DTASOF>20110102000000</DTASOF>
</LEDGERBAL>
</STMTRS>
</STMTTRNRS>
</BANKMSGSRSV1>
</OFX>
    EndOfx
  end
  
end