{% extends '../../common/layouts/layout.tpl' %}


{% block css_assets %}
<link href="/assets/member/styles/plugins/jquery.step.css" rel="stylesheet" type="text/css">
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
      integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
      integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!--表单验证-->
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script><script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
<style>
    p{
        margin: 8px 0 10px;
    }
    button {
        display: inline-block;
        padding: 6px 12px;
        font-size: 14px;
        line-height: 1.42857143;
        text-align: center;
        cursor: pointer;
        border: 1px solid transparent;
        border-radius: 4px;
        color: #fff;
        background-color: #dad9d9;
    }

    .main {
        width: 100%;
        margin: 50px auto 30px;
    }

    #step {
        margin-bottom: 40px;
    }

    .btns {
        float: left;
        width: 100%;
        padding-top: 30px;
    }

    .btns #nextBtn {
        float: right;
    }
    .warninginfo{
        color:red;
        font-size: 12px;
        font-weight: normal;
        display: none;
    }
    .warning input{
        vertical-align: top;
    }
    .info {
        float: left;
        height: 34px;
        line-height: 34px;
        margin-left: 40px;
        font-size: 28px;
        font-weight: bold;
        color: #928787;
    }

    .info span {
        color: red;
    }

    .tab-pane {
        display: none;
    }

    #RealAccountWizardTab1.tab-pane {
        display: block;
    }
    .sign-date-year,
    .sign-date-month,
    .sign-date-day{
        display: inline-block;

    }
    .submitInfo{
        text-align: center;
    }
    #submitInfo{
        display: none;
    }
    #step-fun{
        position: relative;
    }
    .warninginfo.step-next-tips{
        position: absolute;
        top: -45px;
        left: 34.5%;
    }
    #RealAccountWizardTab8 .form-control-static{
        display: inline-block;
        margin: 0px;
        padding: 0;
    }
    #RealAccountWizardTab2 .form-control-static{
        display: inline-block;
        margin: 8px 0 10px;
        padding: 0;
        min-height:12px
    }
    #RealAccountWizardTab5 input[type=checkbox]{
        vertical-align: top;
    }
    .form-control-static{
        padding-top: 0;
        min-height:12px
    }
</style>
{% endblock %}


{% block content %}
<div class="real_accounts" style="width: 100%;">
    <div class="main container">
        <div id="step"></div>
        <div class="tab-pane" id="RealAccountWizardTab1">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <span class="accounts-state">{{ userDatas.state }}</span>
                    <p><strong>Formulir Nomor 107.PBK.01</strong></p>
                    <table style="width: 100%;" border="0">
                        <tbody>
                        <tr>
                            <td width="150">Lampiran</td>
                            <td width="5">:</td>
                            <td>&nbsp;Peraturan Kepala Badan Pengawas</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;Perdagangan Berjangka Komoditi</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;Nomor : 107/BAPPEBTI/PER/11/2013</td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <p><strong>PROFIL PERUSAHAAN PIALANG BERJANGKA</strong></p>
                    <table style="width: 100%;" border="0">
                        <tbody>
                        <tr>
                            <td width="150">Nama </td>
                            <td width="5">&nbsp;:</td>
                            <td>&nbsp;PT Real Time Futures </td>
                        </tr>
                        <tr>
                            <td>Alamat </td>
                            <td>&nbsp;:</td>
                            <td>&nbsp;&nbsp;International Financial Centre Tower 2 Lantai 19 Jl. Jend. Sudirman Kav. 22-23, Jakarta 12920 - Indonesia
                            </td>
                        </tr>
                        <tr>
                            <td>No. Telephone </td>
                            <td>&nbsp;:</td>
                            <td>&nbsp;&nbsp;+62 21 40660888</td>
                        </tr>
                        <tr>
                            <td>Faksimili </td>
                            <td>&nbsp;:</td>
                            <td>&nbsp;&nbsp;+62 21 50509100</td>
                        </tr>
                        <tr>
                            <td>Email<br> </td>
                            <td>&nbsp;:</td>
                            <td>&nbsp; <a href="mailto:customercare@rtfgroups.com">support@rtfutures.co.id</a> </td>
                        </tr>
                        <tr>
                            <td>Home Page </td>
                            <td>&nbsp;:</td>
                            <td>&nbsp;http://www.rtfutures.co.id</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Susunan Pengurus Perusahaan:</strong>
                            </td>
                        </tr>
                        <tr>
                            <td>Direktur Utama </td>
                            <td>&nbsp;:</td>
                            <td>
                                <p>&nbsp; Junaidi Roparulian Simanjuntak</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Direktur Operasional </td>
                            <td>&nbsp;:&nbsp;</td>
                            <td>
                                <p>&nbsp;&nbsp;Agus Supriyoko</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Direktur Kepatuhan </td>
                            <td>&nbsp;:</td>
                            <td>
                                <p>&nbsp;Franky Anatoly Marpaung</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Dewan Komisaris</strong>
                            </td>
                        </tr>
                        <tr>
                            <td>Komisari Utama </td>
                            <td>&nbsp;:</td>
                            <td>
                                <p>&nbsp; Achmad Fauzi</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Komisaris </td>
                            <td>&nbsp;:</td>
                            <td>
                                <p>&nbsp; Narif Rahmat Santosa</p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <hr>
                    <table style="width: 100%;" border="0">
                        <tbody>
                        <tr>
                            <td width="40%">Susunan Pemegang Saham Perusahaan </td>
                            <td width="5">:</td>
                            <td>&nbsp;
                                1.	Mr. X	: 90%
                                <br>
                                &nbsp;
                                2.	Mr. Y	: 10%
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Nomor dan Tanggal Izin Usaha dari Bappebti:</strong>
                            </td>
                        </tr>
                        <tr>
                            <td>Nomor </td>
                            <td>:</td>
                            <td>&nbsp; 192/BAPPEBTI/SI/II/2003</td>
                        </tr>
                        <tr>
                            <td>Tanggal </td>
                            <td>:</td>
                            <td>&nbsp; 24 Pebruari 2003</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Nomor dan Tanggal Keanggotaan Bursa Berjangka</strong>
                            </td>
                        </tr>
                        <tr>
                            <td>Nomor </td>
                            <td>:</td>
                            <td>&nbsp; SPAB/169/JFX/05/2018 &nbsp;&nbsp;&nbsp;&nbsp;Tanggal	:&nbsp;&nbsp;&nbsp;&nbsp; 14 Mei 2018</td>
                        </tr>
                        <tr>
                            <td>Perubahan dari Nomor </td>
                            <td>:</td>
                            <td>&nbsp;  SPAB-043/BBJ/02/02 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tanggal	:&nbsp;&nbsp;&nbsp;&nbsp; 13 Pebruari 2002</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Nomor dan Tanggal Keanggotaan Lembaga Kliring Berjangka</strong>
                            </td>
                        </tr>
                        <tr>
                            <td>Nomor </td>
                            <td>:</td>
                            <td>&nbsp; 35/AK-KBI/PN/V/2018 &nbsp;&nbsp;&nbsp;&nbsp;Tanggal	:&nbsp;&nbsp;&nbsp;&nbsp; 3 Mei 2018</td>
                        </tr>
                        <tr>
                            <td>Perubahan dari Nomor </td>
                            <td>:</td>
                            <td>&nbsp;  22/AK-KBI/V/2004 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tanggal	:&nbsp;&nbsp;&nbsp;&nbsp; 18 Mei 2004</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Nomor dan Tanggal Persetujuan sebagai Peserta Sistem Perdagangan Alternatif: </strong>
                            </td>
                        </tr>
                        <tr>
                            <td>Nomor </td>
                            <td>:</td>
                            <td>&nbsp; 1519/BAPPEBTI/SP/4/2007</td>
                        </tr>
                        <tr>
                            <td>Perubahan dari Nomor </td>
                            <td>:</td>
                            <td>&nbsp;  18 April 2007</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>Nama Penyelenggara Sistem Perdagangan Alternatif </td>
                            <td>:</td>
                            <td>&nbsp;PT Menara Mas Investindo</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>Kontrak Berjangka Yang Diperdagangkan</td>
                            <td>:</td>
                            <td>&nbsp; Terlampir dalam Trading Rules</td>
                        </tr>
                        <tr>
                            <td>Kontrak Derivatif Syariah Yang Diperdagangkan</td>
                            <td>:</td>
                            <td>&nbsp; - </td>
                        </tr>
                        <tr>
                            <td>Kontrak Derivatif dalam Sistem Perdagangan Alternatif</td>
                            <td>:</td>
                            <td>&nbsp; Terlampir dalam Trading Rules</td>
                        </tr>
                        <tr>
                            <td>Kontrak Derivatif dalam Sistem Perdagangan Alternatif dengan volume minimum 0,1 (nol koma satu) lot Yang Diperdagangkan</td>
                            <td>:</td>
                            <td>&nbsp; Terlampir dalam trading rules</td>
                        </tr>
                        <tr>
                            <td>Biaya secara rinci yang dibebankan kepada Nasabah</td>
                            <td>:</td>
                            <td>&nbsp; Terlampir dalam Trading Rules</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Nomor atau alamat email jika terjadi keluhan</strong></td>
                        </tr>
                        <tr>
                            <td>Nomor Telepon</td>
                            <td>:</td>
                            <td>&nbsp; +62 21 40550888</td>
                        </tr>
                        <tr>
                            <td>Alamat Email</td>
                            <td>:</td>
                            <td>&nbsp; compliance@rtfutures.co.id</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Sarana penyelesaian perselisihan yang dipergunakan apabila terjadi perselisihan:</strong>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <ol style="list-style-type: undefined;">
                                    <li style="text-align: justify;">1.	Semua perselisihan dan perbedaan pendapat yang timbul dalam pelaksanaan Perjanjian
                                        ini akan diselesaikan terlebih dahulu secara musyawarah untuk mencapai mufakat antara Para Pihak.
                                    </li>
                                    <li style="text-align: justify;">2.	Apabila perselisihan dan perbedaan pendapat yang timbul tidak dapat diselesaikan
                                        secara musyawarah untuk mencapai mufakat, Para Pihak akan memanfaatkan sarana penyelesaian perselisihan yang tersedia
                                        di Bursa Berjangka.
                                    </li>
                                    <li style="text-align: justify;">3.	Apabila perselisihan dan perbedaan pendapat yang timbul tidak dapat diselesaikan melalui
                                        cara sebagaimana dimaksud pada angka 1 dan angka 2, maka Para Pihak sepakat untuk menyelesaikan perselisihan melalui:
                                        <p>
                                            a.	Badan Arbitrase Perdagangan Berjangka Komoditi (BAKTI) berdasarkan Peraturan dan Prosedur Badan Arbitrase Perdagangan
                                            Berjangka Komoditi (BAKTI); atau
                                        </p>
                                        <p>
                                            b.	Pengadilan Negeri <strong>Jakarta Selatan</strong>
                                        </p>
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Nama-Nama Wakil Pialang Berjangka yang Bekerja di Perusahaan Pialang Berjangka:</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <ol style="list-style-type: undefined;">
                                    <li style="text-align: justify;">1.	Junaidi Roparulian Simanjuntak</li>
                                    <li style="text-align: justify;">2.	Agus Supriyoko</li>
                                    <li style="text-align: justify;">3.	Achmad Fauzi</li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Nama-Nama Wakil Pialang Berjangka yang secara khusus ditunjuk oleh Pialang Berjangka untuk melakukan verifikasi dalam rangka penerimaan Nasabah elektronik on-line:</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <ol style="list-style-type: undefined;">
                                    <li style="text-align: justify;">1.	Mr. X</li>
                                    <li style="text-align: justify;">2.	Mr. Y</li>
                                    <li style="text-align: justify;">3.	Mr. Z</li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <strong>Nomor Rekening Terpisah (Segregated Account) Perusahaan Pialang Berjangka:</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <ol style="list-style-type: undefined;">
                                    <li style="text-align: justify;">1.	Bank Central Asia (BCA)
                                        <p>
                                            -	IDR	: 0353118673 <br>
                                            -	USD	: 0353110443
                                        </p>
                                    </li>
                                    <li style="text-align: justify;">2.	Bank CCB Indonesia
                                        <p>
                                            -	IDR	: 1011663989 <br>
                                            -	USD	: 1011680808
                                        </p>
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <p>&nbsp;</p>
                    <p>
                        <small>*) Isi sesuai dengan kontrak yang diperdagangkan
                        </small>
                    </p>
                    <p>&nbsp;</p>
                    <p class="text-center">
                        <strong>PERNYATAAN TELAH MEMBACA PROFIL PERUSAHAAN PIALANG BERJANGKA</strong>
                    </p>
                    <p>
                        Dengan mengisi kolom "YA" di bawah ini, saya menyatakan bahwa saya telah membaca dan menerima
                        informasi <strong>PROFIL PERUSAHAAN PIALANG BERJANGKA</strong>,mengerti dan memahami
                        isinya.
                    </p>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="RealAccountWizardTab2">
            <div class="row">
                <div class="col-md-8 col-sm-6">
                    <p><strong>Formulir Nomor 107.PBK.02.1</strong></p>
                </div>
                <div class="col-md-4 col-sm-6">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Lampiran</td>
                            <td>:</td>
                            <td>Peraturan Kepala Badan Pengawas</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>Perdagangan Berjangka Komoditi</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>Nomor: 107/BAPPEBTI/PER/11/2013</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 col-sm-12">
                    <p class="text-center">
                        <strong>PERNYATAAN TELAH MELAKUKAN SIMULASI</strong>
                    </p>
                    <p class="text-center">
                        <strong>PERDAGANGAN BERJANGKA KOMODITI</strong>
                    </p>
                    <p>Yang mengisi formulir di bawah ini:</p>

                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-6 control-label">Nama Lengkap</label>
                        <div class="col-md-4 col-sm-6">
                            <p class="form-control-static accountName">{{ userDatas.account_name }}</p>
                        </div>
                    </div>

                    <div class=" step-2-formulir-items">
                        <label class="col-md-2 col-sm-6 control-label">Tempat, Tgl Lahir</label>
                        <div class="col-md-4 col-sm-6">
                            <p class="form-control-static">{{userDatas.open_account_info.place }} {{ userDatas.open_account_info.birthday }}</p>
                        </div>
                    </div>
                    <div class=" step-2-formulir-items">
                        <label class="col-md-2 col-sm-6 control-label">Alamat Rumah</label>
                        <div class="col-md-4 col-sm-6">
                            <p class="form-control-static">{{ userDatas.open_account_info.home_address }}</p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items ">
                        <label class="col-md-2 col-sm-6 control-label">Kode Pos</label>
                        <div class="col-md-4 col-sm-6">
                            <p class="form-control-static"> {{ userDatas.open_account_info.postal_code }} </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items ">
                        <label class="col-md-2 col-sm-6 control-label">No. PASSPORT / passport </label>
                        <div class="col-md-4 col-sm-6">
                            <p class="form-control-static">{{ userDatas.open_account_info.identity_number }}</p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items required" error="has-error" aria-required="true">
                        <label for="RealAccountTradeExperienceAccountNumber" class="col-md-2 col-sm-12 control-label">
                            Demo. Acc
                        </label>
                        <div class="col-md-2 col-sm-12">
                            <input name="data[RealAccountTradeExperience][account_number]"
                                   class="form-control" maxlength="64" type="text"
                                   id="DemoAccountTradeExperienceAccountNumber"
                                   required="required" aria-required="true"
                                   disabled
                                   value="{{ userDatas.open_account_info.open_account_no.demo_account_no }}"
                            >
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <p>&nbsp;</p><p>&nbsp;</p>
                    <p>
                        Dengan mengisi kolom "YA" di bawah ini, saya menyatakan bahwa saya telah melakukan simulasi bertransaksi dibidang Perdagangan Berjangka Komoditi pada Real Time Futures, dan telah memahami tentang tata cara bertransaksi dibidang Perdagangan Berjangka Komoditi.
                    </p>
                    <p>
                        Demikianlah surat pernyataan ini dibuat dengan sebenarnya dalam keadaan sadar, sehat jasmani dan rohani serta tanpa paksaan apapun dari pihak manapun.
                    </p>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="RealAccountWizardTab3">
            <div class="row">
                <div class="form-group step-2-formulir-items" error="has-error">
                    <label for="RealAccountTradeExperienceExperienced" class="col-md-4 col-sm-4 control-label">
                        <strong>Apakah anda sudah berpengalaman dalam transaksi</strong>
                    </label>
                    <div class="col-md-6 col-sm-6" style="width:300px">
                        <select
                                name="data[RealAccountTradeExperience][experienced]"
                                class="form-control"
                                id="RealAccountTradeExperienceExperienced">
                            <option value="0">Tidak</option>
                            <option value="1">Ya</option>
                        </select>
                    </div>
                </div>
            </div>
            <p>&nbsp;</p>
            <div class="row hidden" id="107BPK022">
                <div class="col-md-8 col-sm-6">
                    <strong>Formulir Nomor 107.BPK.02.2</strong>
                </div>
                <div class="col-md-4 col-sm-6">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Lampiran</td>
                            <td>:</td>
                            <td>Peraturan Kepala Badan Pengawas</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>Perdagangan Berjangka Komoditi</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>Nomor: 107/BAPPEBTI/PER/11/2013</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 col-sm-12">
                    <p class="text-center">
                        <strong>SURAT PERNYATAAN TELAH BERPENGALAMAN</strong>
                    </p>
                    <p class="text-center">
                        <strong>MELAKSANAKAN TRANSAKSI PERDAGANGAN BERJANGKA KOMODITI</strong>
                    </p>

                    <p>Yang mengisi formulir dibawah di bawah ini:</p>

                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">Nama Lengkap</label>
                        <div class="col-md-4 col-sm-12">
                            <p class="form-control-static">
                                {{ userDatas.account_name }}
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">Tempat, Tgl Lahir</label>
                        <div class="col-md-4 col-sm-12">
                            <p class="form-control-static">
                                {{userDatas.open_account_info.place }} {{ userDatas.open_account_info.birthday }}
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">Alamat Rumah</label>
                        <div class="col-md-4 col-sm-12">
                            <p class="form-control-static">
                                {{ userDatas.open_account_info.home_address }}
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">Kode Pos</label>
                        <div class="col-md-4 col-sm-12">
                            <p class="form-control-static">
                                {{ userDatas.open_account_info.postal_code }}
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">No. PASSPORT / passport</label>
                        <div class="col-md-4 col-sm-12">
                            <p class="form-control-static">
                                {{ userDatas.open_account_info.identity_number }}
                            </p>
                        </div>
                    </div>

                    <div class="step-2-formulir-items required" error="has-error" aria-required="true">
                        <label for="RealAccountTradeExperienceAccountNumber" class="col-md-2 col-sm-12 control-label">
                            Demo. Acc
                        </label>
                        <div class="col-md-2 col-sm-12">
                            <input name="data[RealAccountTradeExperience][account_number]"
                                   class="form-control" maxlength="64" type="text"
                                   id="RealAccountTradeExperienceAccountNumber"
                                   required="required" aria-required="true"
                                   value="{{ userDatas.open_account_info.open_account_no.demo_account_no }}"
                                   disabled
                            >
                        </div>
                    </div>
                    <p style="clear: both;">&nbsp;</p>
                    <div class="col-md-12 col-sm-12" style="display: table;">
                        Dengan mengisi kolom "YA" di bawah ini, saya menyatakan bahwa saya
                        telah
                        memiliki pengalaman yang mencukupi dalam melaksanakan transaksi
                        Perdagangan berjangka
                        karena pernah bertransaksi pada perusahaan pialang berjangka
                        {% if userDatas.state === 1 %}
                        <input name="data[RealAccountTradeExperience][company_name]"
                               class="form-control"
                               placeholder="Masukkan nama perusahaan Pialang Berjangka"
                               maxlength="64" type="text"
                               id="RealAccountTradeExperienceCompanyName"
                               style="width: 360px;
                                display: inline-table;
                            "
                        >
                        {% else %}
                        <input
                                class="form-control"
                                placeholder="Masukkan nama perusahaan Pialang Berjangka"
                                maxlength="64" type="text"
                                disabled
                                style="width: 360px;
                                        display: inline-table;"
                                value="{{ userDatas.open_account_info.confirm.trade_experience_company }}"
                        >
                        {% endif %}
                        <span class="warninginfo five-step-next-tips" style="width: 100%; ">This field is required.</span>
                        Demikianlah surat pernyataan ini dibuat dengan sebenarnya dalam
                        keadaan sadar,
                        sehat jasmani dan rohani serta tanpa paksaan apapun dari pihak
                        manapun.
                        dan telah memahami tentang tata cara bertransaksi Perdagangan
                        Berjangka.
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="RealAccountWizardTab4">
            <div class="row">
                <div class="col-md-8 col-sm-6">
                    <strong>Formulir Nomor 107.BPK.03</strong>
                </div>
                <div class="col-md-4 col-sm-6">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Lampiran</td>
                            <td>:</td>
                            <td>Peraturan Kepala Badan Pengawas</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>Perdagangan Berjangka Komoditi</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>Nomor: 107/BAPPEBTI/PER/11/2013</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 col-sm-12">
                    <p class="text-center">
                        <strong>APLIKASI PEMBUKAAN REKENING TRANSAKSI</strong>
                    </p>
                    <p class="text-center">
                        <strong>SECARA ELEKTRONIK ON-LINE</strong>
                    </p>
                </div>
                <div class="col-md-12 col-sm-12 text-right">
                    Tanggal: {{ userDatas.gmt_modified }}
                </div>
                <p style="clear: both;"> &nbsp; </p>
                <div class="col-md-12 col-sm-12">
                    <h4>DATA PRIBADI</h4>
                    <hr>
                    <div class="col-md-6 col-sm-12">
                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Nama Lengkap
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.account_name }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Tempat, Tgl Lahir
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{userDatas.open_account_info.place }} {{ userDatas.open_account_info.birthday }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                No. PASSPORT / passport
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.identity_number }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Pengalaman Investasi
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.investment_experience }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Tuj. Buka Rekening
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ Lang.select.member.register.purpose_of_account_opening[ userDatas.open_account_info.purpose_of_account_opening ].label }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                NPWP
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.personal_tax_number }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Jenis Kelamin
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ Lang.select.member.register.gender[ userDatas.open_account_info.purpose_of_account_opening ].label }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Tidak kawin
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ Lang.select.member.register.marital_status[ userDatas.open_account_info.marital_status ].label  }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Nama Suami/Istri</label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{userDatas.open_account_info.spouse_name }}
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-sm-12">
                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Nama Ibu Kandung
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.mother_maiden_name }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Alamat Rumah
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.home_address }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Kode Pos
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.emergency_contact.postal_code }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                Status Rumah
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{  userDatas.open_account_info.house_ownership_other }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                No. Telp Rumah
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    + {{  userDatas.open_account_info.house_number_country_code }} - {{  userDatas.account.open_account_info.house_facsimile_number }}
                                </p>
                            </div>
                        </div>


                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                No. Faksimili Rumah
                            </label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.house_facsimile_number }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-5 col-sm-12 control-label">
                                No. Handphone</label>
                            <div class="col-md-7 col-sm-12">
                                <p class="form-control-static">
                                    + {{ userDatas.open_account_info.mobile_country_code }} - {{ userDatas.open_account_info.mobile_number }}
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12 col-sm-12">
                        <hr>
                        <div class="col-md-8 col-sm-8">
                            Memiliki anggota keluarga yang bekerja di BAPPEBTI/Bursa Berjangka/Kliring Berjangka?
                        </div>
                        <div class="col-md-4 col-sm-4">
                            <label class="radio-inline">
                                <input type="radio"
                                       name="data[RealAccountProfile][have_family_in]"
                                       id="RealAccountProfileHaveFamilyIn0"
                                       disabled="disabled" value="0" checked="checked">
                                Tidak
                            </label>
                            <label class="radio-inline">
                                <input type="radio"
                                       name="data[RealAccountProfile][have_family_in]"
                                       id="RealAccountProfileHaveFamilyIn1"
                                       disabled="disabled" value="1">
                                Ya
                            </label>
                        </div>

                        <div class="col-md-8 col-sm-8">
                            Apakah anda telah dinyatakan pailit oleh pengadilan?
                        </div>
                        <div class="col-md-4 col-sm-4">
                            <label class="radio-inline">
                                <input type="radio"
                                       name="data[RealAccountProfile][bankruptcy]"
                                       id="RealAccountProfileBankruptcy0"
                                       disabled="disabled" value="0" checked="checked">
                                Tidak
                            </label>
                            <label class="radio-inline">
                                <input type="radio"
                                       name="data[RealAccountProfile][bankruptcy]"
                                       id="RealAccountProfileBankruptcy1"
                                       disabled="disabled" value="1">
                                Ya
                            </label>
                        </div>
                    </div>
                </div>
                <p style="clear: both;"> &nbsp; </p>
                <div class="col-md-12 col-sm-12">
                    <h4>PIHAK YANG DIHUBUNGI DALAM KEADAAN DARURAT</h4>
                    <hr>
                    <div class="col-md-6 col-sm-12">
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Nama Lengkap
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.emergency_contact.full_name }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Nomor Telepon
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.emergency_contact.phone_number }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Hubungan
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.emergency_contact.relation_ship }}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Alamat Rumah
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.emergency_contact.home_address }}
                                </p>
                            </div>
                        </div>

                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Kode Pos
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.emergency_contact.postal_code }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <h4>&nbsp;</h4>
                <div class="col-md-12 col-sm-12">
                    <h4>PEKERJAAN</h4>
                    <hr>
                    <div class="col-md-6 col-sm-12">
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Pekerjaan
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.title }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Nama Perusahaan
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.name_of_company }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Bidang Usaha
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.occupation_other }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Jabatan
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.occupation_other }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Lama Bekerja
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.length_of_services }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Di Kantor Sebelumnya
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.length_of_services }}
                                </p>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Alamat
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.company_address }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Kode Pos
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.postal_code }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Telepon Kantor
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.office_phone_number }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Fax Kantor
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_job.office_fax_number }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <h4>&nbsp;</h4>

                <div class="col-md-12 col-sm-12">
                    <h4>Daftar Kekayaan</h4>
                    <hr>
                    <div class="col-md-6 col-sm-12">
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Penghasilan Per Tahun</label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ Lang.select.member.register.annual_income[ userDatas.open_account_info.open_account_wealth_list.annual ].label  }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Rumah Lokasi
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_wealth_list.location_of_house }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Nilai NJOP
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_wealth_list.house_tax_value }}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Deposit Bank
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_wealth_list.time_deposit }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Jumlah
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_wealth_list.total }}
                                </p>
                            </div>
                        </div>
                        <div class="step-2-formulir-items">
                            <label class="col-md-4 col-sm-12 control-label">
                                Lainnya
                            </label>
                            <div class="col-md-8 col-sm-12">
                                <p class="form-control-static">
                                    {{ userDatas.open_account_info.open_account_wealth_list.others }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <h4>&nbsp;</h4>
                <div class="col-md-12 col-sm-12">
                    <p>
                        <strong> Pernyataan kebenaran dan tanggung jawab</strong>
                    </p>
                    <p>
                        Dengan mengisi kolom "YA" di bawah ini, saya menyatakan bahwa semua
                        informasi dan semua dokumen yang saya lampirkan dalam APPLIKASI
                        PEMBUKAAN REKENING TRANSAKSI SECARA ELEKTRONIK ON-LINE adalah benar
                        dan tepat, Saya akan bertanggung jawab penuh apabila dikemudian hari
                        terjadi sesuatu hal sehubungan dengan ketidakbenaran data yang saya
                        berikan.
                    </p>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="RealAccountWizardTab5">
            <div class="row" id="107BPK042">
                <div class="col-md-8 col-sm-6">Formulir Nomor 107.BPK.04.1</div>
                <div class="col-md-4 col-sm-6">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Lampiran</td>
                            <td>:</td>
                            <td>Peraturan Kepala Badan Pengawas</td>
                        </tr>
                        <tr>

                            <td colspan="2">&nbsp;</td>
                            <td>Perdagangan Berjangka Komoditi</td>
                        </tr>
                        <tr>

                            <td colspan="2">&nbsp;</td>
                            <td>Nomor: 107/BAPPEBTI/PER/11/2013</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 col-sm-12">
                    <p class="text-center">
                        <strong>DOKUMEN PEMBERITAHUAN ADANYA RESIKO</strong>
                    </p>
                    <p class="text-center"><strong>
                        YANG HARUS DISAMPAIKAN OLEH PIALANG BERJANGKA</strong>
                    </p>
                    <p class="text-center">
                        <strong>UNTUK TRANSAKSI KONTRAK DERIVATIF DALAM</strong>
                    </p>
                    <p class="text-center">
                        <strong>SISTEM PERDAGANGAN ALTERNATIF</strong>
                    </p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>
                        Dokumen Pemberitahuan Adanya Risiko ini disampaikan kepada anda
                        sesuai dengan Pasal 50 ayat (2) Undang-Undang Nomor 32 Tahun 1997
                        tentang Perdagangan Berjangka Komoditi sebagaimana telah diubah
                        dengan Undang-Undang Nomor 10 Tahun 2011
                        tentang Perubahan Atas Undang-Undang Nomor 32 Tahun 1997 Tentang
                        Perdagangan Berjangka Komoditi
                    </p>
                    <p>
                        Maksud dokumen ini adalah memberitahukan bahwa kemungkinan kerugian
                        atau keuntungan
                        dalam perdagangan Kontrak Derivatif dalam Sistem Perdagangan
                        Alternatif
                        bisa mencapai jumlah yang sangat besar. Oleh karena itu,
                        anda harus berhati-hati dalam memutuskan untuk melakukan transaksi,
                        apakah kondisi keuangan anda mencukupi.
                    </p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                </div>
                <div class="col-md-12 col-sm-12 table-responsive">
                    <form class="cmxform" id="riskconfirm" method="get" action="">
                        <table class="table table-bordered">
                            <tbody>
                            <tr>
                                <td>1</td>
                                <td colspan="2">
                                    <p>
                                        <strong>
                                            Perdagangan Kontrak Derivatif dalam Sistem
                                            Perdagangan Alternatif belum tentu layak bagi semua
                                            investor.
                                        </strong>
                                        Anda dapat menderita kerugian dalam
                                        jumlah besar dan dalam jangka waktu singkat. Jumlah
                                        kerugian uang dimungkinkan dapat melebihi jumlah uang
                                        yang pertama kali Anda setor (Margin awal) ke Pialang
                                        Berjangka Anda.
                                    </p>
                                    <p>Anda mungkin menderita kerugian seluruh Margin dan Margin
                                        tambahan yang ditempatkan pada Pialang Berjangka untuk
                                        mempertahankan posisi Kontrak Derivatif dalam Sistem
                                        Perdagangan Alternatif Anda.
                                    </p>
                                    <p>Hal ini disebabkan Perdagangan Berjangka sangat
                                        dipengaruhi oleh mekanisme leverage, dimana dengan
                                        jumlah investasi dalam bentuk yang relatif kecil dapat
                                        digunakan untuk membuka posisi dengan aset yang bernilai
                                        jauh lebih tinggi. Apabila Anda tidak siap dengan risiko
                                        seperti ini, sebaiknya Anda tidak melakukan perdagangan
                                        Kontrak Derivatif dalam Sistem Perdagangan Alternatif.
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm0ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][0][read_and_understand]"
                                               data-index="0"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm0ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td colspan="2">
                                    <p><strong>Perdagangan Kontrak Berjangka mempunyai risiko
                                        dan mempunyai kemungkinan kerugian yang tidak terbatas
                                        yang jauh lebih besar dari jumlah uang yang disetor
                                        (Margin) ke Pialang Berjangka.</strong>
                                    </p>
                                    <p>Kontrak Derivatif dalam Sistem Perdagangan Alternatif
                                        sama dengan produk keuangan lainnya yang mempunyai
                                        risiko tinggi, Anda sebaiknya tidak menaruh risiko
                                        terhadap dana yang Anda tidak siap untuk menderita rugi,
                                        seperti tabungan pensiun, dana kesehatan atau dana untuk
                                        keadaan darurat, dana yang disediakan untuk pendidikan
                                        atau kepemilikan rumah, dana yang diperoleh dari
                                        pinjaman pendidikan atau gadai, atau dana yang digunakan
                                        untuk memenuhi kebutuhan sehari-hari.
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm1ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][1][read_and_understand]"
                                               data-index="1"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm1ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td colspan="2">
                                    <p><strong>Berhati-hatilah terhadap pernyataan bahwa Anda
                                        pasti mendapatkan keuntungan besar dari perdagangan
                                        Kontrak Derivatif dalam Sistem Perdagangan
                                        Alternatif.</strong>
                                        <br><span class="labeling">Act carefully for the statement which promising that you definitely could gain large profits from Derivative Contracts trading in the Alternative Trading System. Although Derivative.</span>
                                    </p>
                                    <p>Meskipun perdagangan Kontrak Derivatif dalam Sistem
                                        Perdagangan Alternatif dapat memberikan keuntungan yang
                                        besar dan cepat, namun hal tersebut tidak pasti, bahkan
                                        dapat menimbulkan kerugian yang besar dan cepat juga.
                                        Seperti produk keuangan lainnya, tidak ada yang
                                        dinamakan "pasti untung".
                                        <br><span class="labeling">Contracts trading in the Alternative Trading System could provide large benefits and fast, but it is not certain, it could even cause large and fast loss either. As other financial products, there is no so-called "definite profit".</span>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm2ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][2][read_and_understand]"
                                               data-index="2"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm2ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td colspan="2">
                                    <p><strong>Disebabkan adanya mekanisme leverage dan sifat
                                        dari transaksi Kontrak Berjangka, Anda dapat merasakan
                                        dampak bahwa Anda menderita kerugian dalam waktu
                                        cepat.</strong>
                                    </p>
                                    <p>Keuntungan maupun kerugian dalam transaksi Kontrak
                                        Derivatif dalam Sistem Perdagangan Alternatif akan
                                        langsung dikredit atau didebet ke rekening Anda, paling
                                        lambat secara harian. Apabila pergerakan di pasar
                                        terhadap Kontrak Berjangka menurunkan nilai posisi Anda
                                        dalam Kontrak Derivatif dalam Sistem Perdagangan
                                        Alternatif, Anda diwajibkan untuk menambah dana untuk
                                        pemenuhan kewajiban Margin ke Pialang Berjangka. Apabila
                                        rekening Anda berada dibawah minimum Margin yang telah
                                        ditetapkan Lembaga Kliring Berjangka atau Pialang
                                        Berjangka, maka posisi Anda dapat dilikuidasi pada saat
                                        rugi, dan Anda wajib menyelesaikan defisit (jika ada)
                                        dalam rekening Anda.
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm3ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][3][read_and_understand]"
                                               data-index="3"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm3ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td colspan="2">
                                    <p><strong>Pada saat pasar dalam keadaan tertentu, Anda
                                        mungkin akan sulit atau tidak mungkin melikuidasi
                                        posisi.</strong>
                                    </p>
                                    <p>Pada umumnya Anda harus melakukan transaksi mengambil
                                        posisi yang berlawanan dengan maksud melikuidasi posisi
                                        (offset) jika ingin melikuidasi posisi dalam Kontrak
                                        Derivatif dalam Sistem Perdagangan Alternatif. Apabila
                                        Anda tidak dapat melikuidasi posisi Kontrak Derivatif
                                        dalam Sistem Perdagangan Alternatif, Anda tidak dapat
                                        merealisasikan keuntungan pada nilai posisi tersebut
                                        atau mencegah kerugian yang lebih tinggi. Kemungkinan
                                        tidak dapat melikuidasi dapat terjadi, antara lain :
                                        jika perdagangan berhenti dikarenakan aktivitas
                                        perdagangan yang tidak lazim pada Kontrak Derivatif atau
                                        subjek Kontrak Derivatif atau terjadi kerusakan sistem
                                        pada Pialang Berjangka Peserta Sistem Perdagangan
                                        Alternatif atau Pedagang Berjangka Penyelenggara Sistem
                                        Perdagangan Alternatif. Bahkan apabila Anda dapat
                                        melikuidasi posisi tersebut, Anda mungkin terpaksa
                                        melakukannya pada harga yang menimbulkan kerugian besar.
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm4ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][4][read_and_understand]"
                                               data-index="4"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm4ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td colspan="2">
                                    <p><strong>Pada saat pasar dalam keadaan tertentu, Anda
                                        mungkin akan sulit atau tidak mungkin mengelola risiko
                                        atas posisi terbuka Kontrak Derivatif dalam Sistem
                                        Perdagangan Alternatif dengan cara membuka posisi dengan
                                        nilai yang sama namun dengan posisi yang berlawanan
                                        dalam kontrak bulan yang berbeda, dalam pasar yang
                                        berbeda atau dalam "subjek Kontrak Derivatif dalam
                                        Sistem Perdagangan Alternatif" yang berbeda.</strong>
                                    </p>
                                    <p>Kemungkinan untuk tidak dapat mengambil posisi dalam
                                        rangka membatasi risiko yang timbul, contohnya : jika
                                        perdagangan dihentikan pada pasar yang berbeda
                                        disebabkan aktivitas perdagangan yang tidak lazim pada
                                        Kontrak Derivatif dalam Sistem Perdagangan Alternatif
                                        atau "subjek Kontrak Derivatif dalam Sistem Perdagangan
                                        Alternatif".
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm5ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][5][read_and_understand]"
                                               data-index="5"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm5ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>7</td>
                                <td colspan="2">
                                    <p><strong>Anda dapat menderita kerugian yang disebabkan
                                        kegagalan sistem informasi.
                                    </p>
                                    <p>Sebagaimana yang terjadi pada setiap transaksi keuangan,
                                        Anda dapat menderita kerugian jika amanat untuk
                                        melaksanakan transaksi Kontrak Berjangka tidak dapat
                                        dilakukan karena kegagalan sistem informasi di Bursa
                                        Berjangka, penyelenggara maupun sistim informasi di
                                        Pialang Berjangka yang mengelola posisi Anda. Kerugian
                                        Anda akan semakin besar jika Pialang Berjangka yang
                                        mengelola posisi Anda tidak memiliki sistem informasi
                                        cadangan atau prosedur yang layak.
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm6ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][6][read_and_understand]"
                                               data-index="6"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm6ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>8</td>
                                <td colspan="2">
                                    <p><strong>Semua Kontrak Derivatif dalam Sistem Perdagangan
                                        Alternatif mempunyai risiko, dan tidak ada strategi
                                        berdagang yang dapat menjamin untuk menghilangkan risiko
                                        tersebut.</strong>
                                    </p>
                                    <p>Strategi dengan menggunakan kombinasi posisi seperti
                                        spread, dapat sama berisiko seperti posisi long atau
                                        short. Melakukan Perdagangan Berjangka memerlukan
                                        pengetahuan mengenai Kontrak Derivatif dalam Sistem
                                        Perdagangan Alternatif dan pasar berjangka.
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm7ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][7][read_and_understand]"
                                               data-index="7"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm7ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>9</td>
                                <td colspan="2">
                                    <p><strong>Strategi perdagangan harian dalam Kontrak
                                        Derivatif dalam Sistem Perdagangan Alternatif dan produk
                                        lainnya memiliki risiko khusus.</strong>
                                    </p>
                                    <p>Seperti pada produk keuangan lainnya, pihak yang ingin
                                        membeli atau menjual Kontrak Derivatif dalam Sistem
                                        Perdagangan Alternatif yang sama dalam satu hari untuk
                                        mendapat keuntungan dari perubahan harga pada hari
                                        tersebut ("day traders") akan memiliki beberapa risiko
                                        tertentu antara lain jumlah komisi yang besar, risiko
                                        terkena efek pengungkit ("exposure to leverage"), dan
                                        persaingan dengan pedagang profesional. Anda harus
                                        mengerti risiko tersebut dan memiliki pengalaman yang
                                        memadai sebelum melakukan perdagangan harian ("day
                                        trading").
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm8ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][8][read_and_understand]"
                                               data-index="8"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm8ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>10</td>
                                <td colspan="2">
                                    <p><strong>Menetapkan amanat bersyarat, seperti Kontra
                                        Berjangka dilikuidasi pada keadaan tertentu untuk
                                        membatasi rugi (stop loss), mungkin tidak akan dapat
                                        membatasi kerugian Anda sampai jumlah tertentu
                                        saja.</strong>
                                    </p>
                                    <p>Amanat bersyarat tersebut mungkin tidak dapat
                                        dilaksanakan karena terjadi kondisi pasar yang tidak
                                        memungkinkan melikuidasi Kontrak Derivatif dalam Sistem
                                        Perdagangan Alternatif.
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm9ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][9][read_and_understand]"
                                               data-index="9"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm9ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>11</td>
                                <td colspan="2">
                                    <strong>Anda harus membaca dengan seksama dan memahami
                                        perjanjian Pemberian Amanat dengan Pialang Berjangka
                                        Anda sebelum melakukan transaksi Kontrak Derivatif dalam
                                        Sistem Perdagangan Alternatif.</strong>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm10ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>

                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][10][read_and_understand]"
                                               data-index="10"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm10ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>12</td>
                                <td colspan="2">
                                    <strong>Pernyataan singkat ini tidak dapat memuat secara
                                        rinci seluruh risiko atau aspek penting lainnya tentang
                                        Perdagangan Berjangka. Oleh karena itu Anda harus
                                        mempelajari kegiatan Perdagangan Berjangka secara cermat
                                        sebelum memutuskan melakukan transaksi.</strong>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm11ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][11][read_and_understand]"
                                               data-index="11"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm11ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>13</td>
                                <td colspan="2">
                                    <strong>Dokumen Pemberitahuan Adanya Risiko (Risk
                                        Disclosure) ini buat dalam Bahasa Indonesia.</strong>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right warning">
                                    <div class="confirmation-verify">
                                        <strong>
                                            <em>
                                                <label for="RealAccountSftForm12ReadAndUnderstand">
                                                    Saya sudah membaca dan memahami
                                                    <span class="warninginfo">This field is required.</span>
                                                </label>
                                            </em>
                                        </strong>
                                        <input type="checkbox"
                                               name="data[RealAccountSftForm][12][read_and_understand]"
                                               data-index="12"
                                               class="107BPK042-checkbox 107BPK04-checkbox form-s45-checkbox"
                                               value="1"
                                               id="RealAccountSftForm12ReadAndUnderstand">
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p class="text-center">
                        <strong>PERNYATAAN MENERIMA PEMBERITAHUAN ADANYA RISIKO</strong>
                    </p>
                    <p class="text-center">
                        Dengan mengisi kolom "YA" di bawah, saya
                        menyatakan bahwa saya telah menerima
                    </p>
                    <p class="text-center">
                        <strong>"DOKUMEN PEMBERITAHUAN ADANYA RISIKO"</strong>
                    </p>
                    <p class="text-center">mengerti dan juga menyetujui isinya.</p>
                    <p>&nbsp;</p>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="RealAccountWizardTab6">
            <div class="row">
                <div class="col-md-8 col-sm-6 hidden 107BPK051">Formulir Nomor 107.BPK.05.1</div>
                <div class="col-md-8 col-sm-6 107BPK052 show">Formulir Nomor 107.BPK.05.2</div>
                <div class="col-md-4 col-sm-6">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Lampiran</td>
                            <td>:</td>
                            <td>Peraturan Kepala Badan Pengawas</td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td>Perdagangan Berjangka Komoditi</td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td>Nomor: 107/BAPPEBTI/PER/11/2013</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 col-sm-12">
                    <p class="text-center">
                        <strong>PERJANJIAN PEMBERIAN AMANAT SECARA ELEKTRONIK ON- LINE</strong>
                    </p>
                    <p class="text-center hidden 107BPK051">
                        <strong>UNTUK TRANSAKSI KONTRAK BERJANGKA</strong>
                    </p>
                    <p class="text-center 107BPK052 show">
                        <strong>UNTUK TRANSAKSI KONTRAK DERIVATIF</strong>
                    </p>
                    <p class="text-center 107BPK052 show">
                        <strong>DALAM SISTEM PERDAGANGAN ALTERNATIF</strong>
                    </p>
                    <p>&nbsp;</p>
                    <div class="alert alert-danger text-center">
                        <strong>PERHATIAN !</strong>
                        <br>
                        PERJANJIAN INI MERUPAKAN KONTRAK HUKUM HARAP DIBACA DENGAN SEKSAMA
                    </div>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>
                        Pada hari ini Kamis, tanggal <div class="sign-date-day">2018</div>, bulan <div class="sign-date-month">2018</div>, tahun <div class="sign-date-year">2018</div> , kami yang mengisi perjanjian di bawah
                    ini:
                    </p>
                    <ol type="1">
                        <li>
                            <div class="step-2-formulir-items">
                                <label class="col-md-2 col-sm-6 control-label">
                                    Nama
                                </label>
                                <div class="col-md-10 col-sm-6">
                                    <p class="form-control-static">: {{ userDatas.account_name }}</p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-2 col-sm-6 control-label">
                                    Pekerjaan/Jabatan
                                </label>
                                <div class="col-md-10 col-sm-6">
                                    <p class="form-control-static">:
                                        swasta
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-2 col-sm-6 control-label">
                                    Alamat
                                </label>
                                <div class="col-md-6 col-sm-6">
                                    <p class="form-control-static">:
                                        {{ userDatas.open_account_info.home_address }}
                                    </p>
                                </div>
                            </div>
                            <p>
                                dalam hal ini bertindak untuk dan atas nama sendiri yang selanjutnya disebut <strong>Nasabah</strong>
                            </p>
                        </li>
                        <li>
                            <div class="step-2-formulir-items">
                                <label class="col-md-2 col-sm-6 control-label">
                                    Nama
                                </label>
                                <div class="col-md-10 col-sm-6">
                                    <p class="form-control-static">: .........</p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-2 col-sm-6 control-label">
                                    Pekerjaan/Jabatan
                                </label>
                                <div class="col-md-10 col-sm-6">
                                    <p class="form-control-static">: .........</p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-2 col-sm-6 control-label">
                                    Alamat
                                </label>
                                <div class="col-md-10 col-sm-6">
                                    <p class="form-control-static">: .........</p>
                                </div>
                            </div>
                            <p>dalam hal ini bertindak untuk dan atas nama <strong>Real Time Futures</strong> yang
                                selanjutnya disebut <strong>Pialang Berjangka,</strong></p>
                        </li>

                    </ol>

                    <p>&nbsp;</p>
                    <p>&nbsp;</p>

                    <p>Nasabah dan Pialang Berjangka secara bersama-sama selanjutnya disebut <strong>Para
                        Pihak.</strong></p>
                </div>
            </div>
            <div class="row  107BPK051 hidde">
                <div class="col-md-12 col-sm-12">
                    <p>Para Pihak sepakat untuk mengadakan Perjanjian Pemberian Amanat untuk melakukan transaksi
                        penjualan maupun pembelian Kontrak Berjangka dengan ketentuan sebagai berikut:</p>
                </div>
                <div class="col-md-12 col-sm-12 table-responsive">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <td>1</td>
                            <td colspan="2">
                                <strong>Margin dan Pembayaran Lainnya</strong>
                                <ol type="a">
                                    <li><strong>Nasabah menempatkan sejumlah dana</strong> (Margin) ke Rekening Terpisah
                                        <i>(Segregated Account)</i> Pialang Berjangka sebagai Margin Awal dan wajib
                                        mempertahankannya sebagaimana ditetapkan.
                                    </li>
                                    <li>Membayar biaya-biaya yang diperlukan untuk transaksi yaitu biaya transaksi,
                                        pajak, komisi, dan biaya pelayanan, biaya bunga sesuai tingkat yang berlaku, dan
                                        biaya lainnya yang dapat dipertanggungjawabkan berkaitan dengan transaksi sesuai
                                        amanat Nasabah, maupun biaya rekening Nasabah.
                                    </li>
                                </ol>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm0ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][0][read_and_understand]"
                                           data-index="0"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm0ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>2</td>
                            <td colspan="2">
                                <p>
                                    <strong>Pelaksanaan Amanat</strong>
                                </p>
                                <ol type="1">
                                    <li>Setiap amanat yang disampaikan oleh Nasabah atau kuasanya yang ditunjuk secara
                                        tertulis oleh Nasabah, dianggap sah apabila diterima oleh Pialang Berjangka
                                        sesuai dengan ketentuan yang berlaku, dapat berupa amanat tertulis yang
                                        ditandatangani oleh Nasabah atau kuasanya, amanat telepon yang direkam, dan/atau
                                        amanat transaksi elektronik lainnya.
                                    </li>
                                    <li>Setiap amanat Nasabah yang diterima dapat langsung dilaksanakan sepanjang nilai
                                        Margin yang tersedia pada rekeningnya mencukupi dan eksekusinya tergantung pada
                                        kondisi dan sistem transaksi yang berlaku yang mungkin dapat menimbulkan
                                        perbedaan waktu terhadap proses pelaksanaan amanat tersebut. Nasabah harus
                                        mengetahui posisi Margin dan posisi terbuka sebelum memberikan amanat untuk
                                        transaksi berikutnya.
                                    </li>
                                    <li>Amanat Nasabah hanya dapat dibatalkan dan/atau diperbaiki apabila transaksi atas
                                        amanat tersebut belum terjadi. Pialang Berjangka tidak bertanggung jawab atas
                                        kerugian yang timbul akibat tidak terlaksananya pembatalan dan/atau perbaikan
                                        sepanjang bukan karena kelalaian Pialang Berjangka.
                                    </li>
                                    <li>Pialang Berjangka berhak menolak amanat Nasabah apabila harga yang ditawarkan
                                        atau diminta tidak wajar.
                                    </li>
                                </ol>

                                <p></p>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm1ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][1][read_and_understand]"
                                           data-index="1"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm1ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td colspan="2">
                                <strong>Antisipasi Penyerahan Barang</strong>
                                <ol type="a" class="normal">
                                    <li>Untuk kontrak-kontrak tertentu penyelesaian transaksi dapat dilakukan dengan
                                        penyerahan &nbsp;atau &nbsp;penerimaan&nbsp; barang &nbsp;(delivery) &nbsp;apabila
                                        &nbsp;kontrak &nbsp;jatuh &nbsp;tempo. Nasabah &nbsp;menyadari bahwa penyerahan
                                        &nbsp;atau &nbsp;penerimaan&nbsp; barang &nbsp;mengandung risiko yang lebih
                                        besar daripada melikuidasi posisi dengan offset. Penyerahan fisik barang
                                        memiliki konsekuensi kebutuhan &nbsp;dana yang lebih besar serta tambahan biaya
                                        pengelolaan barang.
                                    </li>
                                    <li>Pialang Berjangka tidak bertanggung jawab atas klasifikasi &nbsp;mutu (grade),
                                        kualitas atau tingkat toleransi atas komoditi yang diserahkan atau akan
                                        diserahkan.
                                    </li>
                                    <li>Pelaksanaan &nbsp;penyerahan &nbsp;atau &nbsp;penerimaan&nbsp; barang &nbsp;tersebut
                                        &nbsp;akan &nbsp;diatur &nbsp;dan dijamin oleh Lembaga Kliring Berjangka.
                                    </li>
                                </ol>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm2ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][2][read_and_understand]"
                                           data-index="2"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm2ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td colspan="2">
                                <strong>Kewajiban Memelihara Margin</strong>
                                <ol type="a" class="normal">
                                    <li>Nasabah wajib memelihara / memenuhi tingkat Margin yang harus tersedia di
                                        rekening pada Pialang Berjangka sesuai dengan jumlah yang telah ditetapkan baik
                                        diminta ataupun tidak oleh Pialang Berjangka.
                                    </li>
                                    <li>Apabila jumlah Margin memerlukan penambahan maka Pialang Berjangka wajib
                                        memberitahukan dan memintakan kepada Nasabah untuk menambah Margin segera.
                                    </li>
                                    <li>Apabila jumlah Margin memerlukan tambahan (<i>Call Margin</i>) maka nasabah
                                        wajib melakukan penyerahan <i>Call Margin</i> selambat-lambatnya sebelum dimulai
                                        hari perdagangan berikutnya. Kewajiban Nasabah sehubungan dengan penyerahan <i>Call
                                            Margin</i> tidak terbatas pada jumlah Margin Awal.
                                    </li>
                                    <li>Pialang Berjangka tidak berkewajiban melaksanakan amanat untuk melakukan
                                        transaksi yang baru dari Nasabah sebelum <i>Call Margin</i> dipenuhi;
                                    </li>
                                    <li>Untuk memenuhi kewajiban <i>Call Margin</i> dan keuangan lainnya dari Nasabah,
                                        Pialang Berjangka dapat mencairkan dana Nasabah yang ada di Pialang Berjangka.
                                    </li>
                                </ol>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm3ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][3][read_and_understand]"
                                           data-index="3"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm3ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td colspan="2">
                                <p><strong>Hak Pialang Berjangka Melikuidasi Posisi Nasabah</strong></p>
                                <p>Nasabah bertanggung jawab memantau/mengetahui posisi terbukanya secara terus- menerus&nbsp;
                                    dan memenuhi kewajibannya. Apabila &nbsp;dalam jangka waktu tertentu &nbsp;dana pada
                                    rekening Nasabah&nbsp; kurang &nbsp;dari yang dipersyaratkan, &nbsp;Pialang
                                    Berjangka dapat menutup &nbsp;posisi terbuka &nbsp;Nasabah &nbsp;secara&nbsp;
                                    keseluruhan &nbsp;atau &nbsp;sebagian, membatasi transaksi, &nbsp;atau &nbsp;tindakan
                                    &nbsp;lain &nbsp;untuk &nbsp;melindungi diri&nbsp; dalam &nbsp;pemenuhan &nbsp;Margin
                                    tersebut dengan terlebih dahulu memberitahu atau tanpa memberitahu Nasabah &nbsp;dan
                                    Pialang Berjangka tidak bertanggung jawab atas kerugian yang timbul akibat tindakan
                                    tersebut.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm4ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][4][read_and_understand]"
                                           data-index="4"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm4ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td colspan="2">
                                <p><strong>Penggantian Kerugian Tidak Menyerahkan Barang</strong></p>
                                <p>Apabila &nbsp;Nasabah &nbsp;tidak mampu menyerahkan komoditi atas Kontrak &nbsp;Berjangka
                                    yang jatuh tempo, Nasabah memberikan kuasa kepada Pialang Berjangka untuk meminjam
                                    atau&nbsp; &nbsp;membeli komoditi&nbsp; untuk&nbsp; &nbsp;penyerahan &nbsp;tersebut.&nbsp;
                                    &nbsp;Nasabah&nbsp; &nbsp;wajib &nbsp;membayar secepatnya&nbsp; semua &nbsp;biaya,
                                    kerugian&nbsp; dan &nbsp;premi yang telah &nbsp;dibayarkan &nbsp;oleh Pialang
                                    Berjangka atas&nbsp;&nbsp; tindakan &nbsp;tersebut. Apabila&nbsp; &nbsp;Pialang
                                    &nbsp;Berjangka &nbsp;harus&nbsp; &nbsp;menerima penyerahan komoditi atau &nbsp;surat
                                    &nbsp;berharga maka Nasabah &nbsp;bertanggung &nbsp;jawab atas penurunan nilai dari
                                    komoditi atas surat berharga tersebut.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm5ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][5][read_and_understand]"
                                           data-index="5"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm5ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td colspan="2">
                                <p><strong>Penggantian Kerugian Tidak Adanya Penutupan Posisi</strong></p>
                                <p>
                                </p>
                                <p>Apabila &nbsp;Nasabah &nbsp;tidak &nbsp;mampu &nbsp;melakukan&nbsp; penutupan &nbsp;atas
                                    &nbsp;transaksi &nbsp;yang jatuh tempo, Pialang Berjangka dapat &nbsp;melakukan
                                    &nbsp;penutupan &nbsp;atas &nbsp;transaksi &nbsp;di&nbsp;&nbsp; Bursa. Nasabah wajib
                                    membayar biaya-biaya, termasuk biaya kerugian dan premi yang telah dibayarkan oleh
                                    Pialang Berjangka, dan apabila Nasabah lalai untuk membayar biaya- biaya tersebut,&nbsp;
                                    Pialang Berjangka berhak untuk &nbsp;mengambil pembayaran dari dana Nasabah</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm6ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][6][read_and_understand]"
                                           data-index="6"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm6ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td colspan="2">
                                <p><strong>Pialang Berjangka Dapat Membatasi Posisi </strong></p>
                                <p>Nasabah mengakui hak Pialang Berjangka untuk&nbsp;membatasi posisi terbuka Kontrak
                                    Berjangka&nbsp; Nasabah &nbsp;dan Nasabah &nbsp;tidak melakukan&nbsp; transaksi
                                    &nbsp;melebihi batas &nbsp;yang telah ditetapkan tersebut.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm7ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][7][read_and_understand]"
                                           data-index="7"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm7ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>9</td>
                            <td colspan="2">
                                <p><strong>Tidak Ada Jaminan atas Informasi atau Rekomendasi</strong></p>
                                <p>Nasabah mengakui bahwa :</p>
                                <ol type="a">
                                    <li>Informasi dan rekomendasi yang diberikan oleh Pialang Berjangka kepada Nasabah
                                        tidak selalu lengkap dan perlu diverifikasi.
                                    </li>
                                    <li>Pialang Berjangka tidak menjamin bahwa informasi dan rekomendasi yang diberikan
                                        merupakan informasi yang akurat dan lengkap.
                                    </li>
                                    <li>Informasi dan rekomendasi yang diberikan oleh wakil Pialang Berjangka yang satu
                                        dengan yang lain mungkin berbeda karena perbedaan analisis fundamental atau
                                        teknikal. Nasabah menyadari bahwa ada kemungkinan Pialang Berjangka dan pihak
                                        terafiliasinya memiliki posisi di pasar dan memberikan rekomendasi tidak
                                        konsisten kepada Nasabah.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm8ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][8][read_and_understand]"
                                           data-index="8"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm8ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>10</td>
                            <td colspan="2">
                                <strong>Pembatasan Tanggung Jawab Pialang Berjangka.</strong>
                                <ol type="a">
                                    <li>Pialang Berjangka tidak bertanggung jawab untuk memberikan penilaian kepada
                                        Nasabah mengenai iklim, pasar, keadaan politik dan ekonomi nasional dan
                                        internasional, nilai kontrak berjangka, kolateral, atau memberikan nasihat
                                        mengenai keadaan pasar. Pialang Berjangka hanya memberikan pelayanan untuk
                                        melakukan transaksi secara jujur serta memberikan laporan atas transaksi
                                        tersebut.
                                    </li>
                                    <li>Perdagangan sewaktu-waktu dapat dihentikan oleh pihak yang memiliki otoritas
                                        (Bappebti / Bursa Berjangka) tanpa pemberitahuan terlebih dahulu kepada Nasabah.
                                        Atas posisi terbuka yang masih dimiliki oleh Nasabah pada saat perdagangan
                                        tersebut dihentikan, maka akan diselesaikan (likuidasi) berdasarkan pada
                                        peraturan / ketentuan yang dikeluarkan dan ditetapkan oleh pihak otoritas
                                        tersebut, dan semua kerugian serta biaya yang timbul sebagai akibat
                                        dihentikannya transaksi oleh pihak otoritas perdagangan tersebut, menjadi beban
                                        dan tanggung jawab Nasabah sepenuhnya.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm9ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][9][read_and_understand]"
                                           data-index="9"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm9ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>11</td>
                            <td colspan="2">
                                <p><strong>Transaksi Harus Mematuhi Peraturan Yang Berlaku</strong></p>
                                <p>
                                </p>
                                <p>Semua transaksi baik yang dilakukan sendiri oleh Nasabah maupun melalui Pialang
                                    Berjangka wajib mematuhi peraturan perundang-undangan di bidang Perdagangan
                                    Berjangka, kebiasaan dan interpretasi resmi yang ditetapkan oleh Bappebti atau Bursa
                                    Berjangka.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm10ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][10][read_and_understand]"
                                           data-index="10"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm10ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>12</td>
                            <td colspan="2">
                                <p><strong>Pialang Berjangka tidak Bertanggung jawab atas Kegagalan Komunikasi</strong>
                                </p>
                                <p>Pialang Berjangka tidak bertanggung jawab atas keterlambatan atau tidak tepat
                                    waktunya pengiriman amanat atau informasi lainnya yang disebabkan oleh kerusakan
                                    fasilitas komunikasi atau sebab lain diluar kontrol Pialang Berjangka.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm11ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][11][read_and_understand]"
                                           data-index="11"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm11ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>13</td>
                            <td colspan="2">
                                <strong>Konfirmasi</strong>
                                <ol type="a">
                                    <li>Konfirmasi dari Nasabah dapat berupa surat, telex, media lain, secara tertulis
                                        ataupun rekaman suara.
                                    </li>
                                    <li>Pialang Berjangka berkewajiban menyampaikan konfirmasi transaksi, laporan
                                        rekening, permintaan Call Margin, dan pemberitahuan lainnya kepada Nasabah
                                        secara akurat, benar dan secepatnya pada alamat Nasabah sesuai dengan yang
                                        tertera dalam rekening Nasabah. Apabila dalam jangka waktu 2 x 24 jam setelah
                                        amanat jual atau beli disampaikan, tetapi Nasabah belum menerima konfirmasi
                                        tertulis, Nasabah segera memberitahukan hal tersebut kepada Pialang Berjangka
                                        melalui telepon dan disusul dengan pemberitahuan tertulis.
                                    </li>
                                    <li>Jika dalam waktu 2 x 24 jam sejak tanggal penerimaan konfirmasi tertulis
                                        tersebut tidak ada sanggahan dari Nasabah maka konfirmasi Pialang Berjangka
                                        dianggap benar dan sah.
                                    </li>
                                    <li>Kekeliruan atas konfirmasi yang diterbitkan Pialang Berjangka akan diperbaiki
                                        oleh Pialang Berjangka sesuai keadaan yang sebenarnya dan demi hukum konfirmasi
                                        yang lama batal.
                                    </li>
                                    <li>Nasabah tidak bertanggung jawab atas transaksi yang dilaksanakan atas
                                        rekeningnya apabila konfirmasi tersebut tidak disampaikan secara benar dan
                                        akurat.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm12ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][12][read_and_understand]"
                                           data-index="12"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm12ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>14</td>
                            <td colspan="2">
                                <p><strong>Kebenaran informasi Nasabah</strong></p>
                                <p>Nasabah memberikan informasi yang benar dan akurat mengenai data Nasabah yang diminta
                                    oleh Pialang Berjangka dan akan memberitahukan paling lambat dalam waktu 3 (tiga)
                                    hari kerja setelah terjadi perubahan, termasuk perubahan kemampuan keuangannya untuk
                                    terus melaksanakan transaksi.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm13ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][13][read_and_understand]"
                                           data-index="13"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm13ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>15</td>
                            <td colspan="2">
                                <p><strong>Komisi Transaksi</strong></p>
                                <p>Nasabah mengetahui dan menyetujui bahwa Pialang Berjangka berhak untuk memungut
                                    komisi atas transaksi yang telah dilaksanakan, dalam jumlah sebagaimana akan
                                    ditetapkan dari waktu ke waktu oleh Pialang Berjangka. Perubahan beban <i>(fees)</i>
                                    dan biaya lainnya harus disetujui secara tertulis oleh Para Pihak.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm14ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][14][read_and_understand]"
                                           data-index="14"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm14ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>16</td>
                            <td colspan="2">
                                <p><strong>Pemberian Kuasa</strong></p>
                                <p>Nasabah memberikan kuasa kepada Pialang Berjangka untuk menghubungi bank, lembaga
                                    keuangan, Pialang Berjangka lain, atau institusi lain yang terkait untuk memperoleh
                                    keterangan atau verifikasi mengenai informasi yang diterima dari Nasabah. Nasabah
                                    mengerti bahwa penelitian mengenai data hutang pribadi dan bisnis dapat dilakukan
                                    oleh Pialang Berjangka apabila diperlukan. Nasabah diberikan kesempatan untuk
                                    memberitahukan secara tertulis dalam jangka waktu yang telah disepakati untuk
                                    melengkapi persyaratan yang diperlukan. </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm15ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][15][read_and_understand]"
                                           data-index="15"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm15ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>17</td>
                            <td colspan="2">
                                <p><strong>Pemindahan Dana</strong></p>
                                <p>Pialang Berjangka dapat setiap saat mengalihkan dana dari satu rekening ke rekening
                                    lainnya berkaitan dengan kegiatan transaksi yang dilakukan Nasabah seperti
                                    pembayaran komisi, pembayaran biaya transaksi, kliring, dan keterlambatan dalam
                                    memenuhi kewajibannya, tanpa terlebih dahulu memberitahukan kepada Nasabah. Transfer
                                    yang telah dilakukan akan segera diberitahukan secara tertulis kepada Nasabah.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm16ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][16][read_and_understand]"
                                           data-index="16"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm16ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>18</td>
                            <td colspan="2">
                                <strong>Pemberitahuan</strong>
                                <ol type="a">
                                    <li>Semua komunikasi, uang, surat berharga, dan kekayaan lainnya harus dikirimkan
                                        langsung ke alamat Nasabah seperti tertera dalam rekeningnya atau alamat lain
                                        yang ditetapkan / diberitahukan secara tertulis oleh Nasabah.
                                    </li>
                                    <li>
                                        Semua uang, harus disetor atau ditransfer langsung oleh Nasabah ke Rekening
                                        Terpisah <i>(Segregated Account)</i> Pialang Berjangka :
                                        <dl class="dl-horizontal">
                                            <dt>&nbsp;</dt>
                                            <dd>&nbsp;</dd>
                                            <dt>Nama</dt>
                                            <dd>PT Real Time Futures</dd>
                                            <dt>Alamat</dt>
                                            <dd>lnternational Financial Centre Tower 2 Lantai 19, JI. Jend.Sudirman Kav.22-23, Jakarta 12920 - Indonesia
                                            </dd>
                                            <dt>Bank</dt>
                                            <dd>BCA - KCU Sudirman</dd>
                                            <dt>No. Rekening Terpisah</dt>
                                            <dd>
                                                0353118673(IDR) <br>
                                                0353110443(USD) <br><br>
                                                CCB Indonesia - KK Rawamangun Jakarta<br>
                                                1011663989(IDR) <br>
                                                1011680808(USD) <br>
                                            </dd>
                                        </dl>
                                        dan dianggap sudah diterima oleh Pialang Berjangka apabila sudah ada tanda terima bukti setor atau transfer dari pegawai Pialang Berjangka.
                                    </li>
                                    <li>
                                        Semua surat berharga, kekayaan lainnya, atau komunikasi harus dikirim kepada
                                        Pialang Berjangka :
                                        <dl class="dl-horizontal">
                                            <dt>&nbsp;</dt>
                                            <dd>&nbsp;</dd>
                                            <dt>Nama</dt>
                                            <dd>PT Real Time Futures</dd>
                                            <dt>Alamat</dt>
                                            <dd> lnternational Financial Centre Tower 2 Lantai 19, JI. Jend.Sudirman Kav.22-23, Jakarta 12920 - Indonesia
                                            </dd>
                                            <dt>Telepon</dt>
                                            <dd>+62 21 40660888</dd>
                                            <dt>Facsimile</dt>
                                            <dd>+62 21 50509100</dd>
                                            <dt>E-mail</dt>
                                            <dd>finance@trfutures.co.id</dd>
                                        </dl>
                                        dan dianggap sudah diterima oleh Pialang Berjangka apabila sudah ada tanda bukti
                                        penerimaan dari pegawai Pialang Berjangka.
                                    </li>
                                </ol>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm17ReadAndUnderstand">
                                                Saya sudah membaca dan memahami

                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][17][read_and_understand]"
                                           data-index="17"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm17ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>19</td>
                            <td colspan="2">
                                <p><strong>Dokumen Pemberitahuan Adanya Resiko</strong></p>
                                <p>Nasabah mengakui menerima dan mengerti Dokumen Pemberitahuan Adanya Resiko.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm18ReadAndUnderstand">
                                                Saya sudah membaca dan memahami

                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][18][read_and_understand]"
                                           data-index="18"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm18ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>20</td>
                            <td colspan="2">
                                <strong>Jangka Waktu Perjanjian dan Pengakhiran</strong>
                                <ol type="a" class="normal">
                                    <li>Perjanjian ini mulai berlaku terhitung sejak tanggal ditandatanganinya sampai
                                        disampaikannya pemberitahuan pengakhiran secara tertulis oleh Nasabah atau
                                        Pialang Berjangka.
                                    </li>
                                    <li>Nasabah dapat mengakhiri Perjanjian ini hanya jika Nasabah sudah tidak lagi
                                        memiliki posisi terbuka dan tidak ada kewajiban Nasabah yang diemban oleh atau
                                        terhutang kepada Pialang Berjangka.
                                    </li>
                                    <li>Pengakhiran tidak membebaskan salah satu Pihak dari tanggung jawab atau
                                        kewajiban yang terjadi sebelum pemberitahuan tersebut.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm19ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][19][read_and_understand]"
                                           data-index="19"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm19ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>21</td>
                            <td colspan="2">
                                <p><strong>Berakhirnya Perjanjian</strong></p>
                                <p>Perjanjian dapat berakhir dalam hal Nasabah :</p>
                                <ol type="a">
                                    <li>dinyatakan pailit, memiliki hutang yang sangat besar, dalam proses peradilan,
                                        menjadi hilang ingatan, mengundurkan diri atau meninggal;
                                    </li>
                                    <li>tidak dapat memenuhi atau mematuhi perjanjian ini dan / atau melakukan
                                        pelanggaran terhadapnya;
                                    </li>
                                    <li>berkaitan dengan angka (1) dan (2) tersebut diatas, Pialang Berjangka dapat :
                                        <ol type="i">
                                            <li>meneruskan atau menutup posisi Nasabah tersebut setelah
                                                mempertimbangkannya secara cermat dan jujur ; dan
                                            </li>
                                            <li>menolak perintah dari Nasabah atau kuasanya.</li>
                                        </ol>
                                    </li>
                                    <li>Pengakhiran Perjanjian sebagaimana dimaksud dengan poin a dan b tersebut diatas
                                        tidak melepaskan kewajiban dari Para Pihak yang berhubungan dengan penerimaan
                                        atau kewajiban pembayaran atau pertanggungjawaban kewajiban lainnya yang timbul
                                        dari Perjanjian.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm20ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][20][read_and_understand]"
                                           data-index="20"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm20ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>22</td>
                            <td colspan="2">
                                <p><strong>Force Majeur</strong></p>
                                <p>Tidak ada satupun pihak di dalam perjanjian dapat diminta pertanggungjawabannya untuk
                                    suatu keterlambatan atau terhalangnya memenuhi kewajiban berdasarkan Perjanjian yang
                                    diakibatkan oleh suatu sebab yang berada di luar kemampuannya atau kekuasaannya (<i>force
                                        majeur</i>), sepanjang pemberitahuan tertulis mengenai sebab itu disampaikannya
                                    kepada pihak lain dalam Perjanjian dalam waktu tidak lebih dari 24 (dua puluh empat)
                                    jam sejak timbulnya sebab itu. Yang dimaksud dengan <i>force majeur</i> dalam
                                    Perjanjian adalah peristiwa kebakaran, bencana alam (seperti gempa bumi, banjir,
                                    angin topan, petir), pemogokan umum, huru hara, peperangan, perubahan terhadap
                                    peraturan perundang-undangan yang berlaku di bidang ekonomi, keuangan dan
                                    Perdagangan Berjangka, pembatasan yang dilakukan oleh otoritas Perdagangan Berjangka
                                    dan Bursa Berjangka serta terganggunya sistem perdagangan, kliring dan penyelesaian
                                    transaksi Kontrak Berjangka di mana transaksi dilaksanakan yang secara langsung
                                    mempengaruhi pelaksanaan pekerjaan berdasarkan Perjanjian.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm21ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][21][read_and_understand]"
                                           data-index="21"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm21ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>23</td>
                            <td colspan="2">
                                <p><strong>Perubahan Atas lsian dalam Perjanjian Pemberian Amanat</strong></p>
                                <p>Perubahan atas isian dalam Perjanjian pemberian ini hanya dapat dilakukan atas
                                    persetujuan Para Pihak, atau Pialang Berjangka telah memberitahukan secara tertulis
                                    perubahan yang diinginkan, dan Nasabah tetap memberikan perintah untuk transaksi
                                    dengan tanpa memberikan tanggapan secara tertulis atas usul perubahan tersebut.
                                    Tindakan Nasabah tersebut dianggap setuju atas usul perubahan tersebut.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm22ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][22][read_and_understand]"
                                           data-index="22"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm22ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>24</td>
                            <td colspan="2">
                                <strong>Penyelesaian Perselisihan</strong>
                                <ol type="a" class="normal">
                                    <li>Semua perselisihan dan perbedaan pendapat yang timbul dalam pelaksanaan
                                        perjanjian ini wajib diselesaikan terlebih dahulu secara musyawarah untuk
                                        mencapai mufakat antara Para Pihak.
                                    </li>
                                    <li>Apabila perselisihan dan perbedaan pendapat yang timbul tidak dapat diselesaikan
                                        secara musyawarah untuk mencapai mufakat, Para Pihak wajib memanfaatkan sarana
                                        penyelesaian perselisihan yang tersedia di Bursa Berjangka.
                                    </li>
                                    {% if userDatas.state === 1 %}
                                    <li>Apabila Perselisihan dan perbedaan pendapat yang timbul tidak dapat diselesaikan
                                        melalui cara sebagaimana dimaksud pada angka (1) dan angka (2), maka Para Pihak
                                        sepakat untuk menyelesaikan perselisihan melalui :
                                        <br>
                                        <label class="radio">
                                            <input type="radio"
                                                   name="data[RealAccountStepFife][settlement_of_disputes_1]"
                                                   id="RealAccountStepFifeSettlementOfDisputes1Bakti"
                                                   class="s51-settlement_of_disputes" value="1"
                                                   checked
                                            >Badan Arbitrase
                                            Perdagangan Berjangka Komoditi (BAKTI) berdasarkan Peraturan dan Prosedur
                                            BAKTI ;
                                        </label>
                                        <label class="radio">
                                            <input type="radio"
                                                   name="data[RealAccountStepFife][settlement_of_disputes_1]"
                                                   id="RealAccountStepFifeSettlementOfDisputes1PengadilanNegeri"
                                                   class="s51-settlement_of_disputes" value="2">Pengadilan
                                            Negeri </label>
                                        <input name="data[RealAccountTradeExperience][account_number]"
                                               class="form-control" maxlength="64" type="text"
                                               id="RealAccountSfftForm24PengadilanNegeri"
                                               required="required" aria-required="true"
                                        >
                                    </li>
                                    <li>Kantor atau kantor cabang Pialang Berjangka terdekat dengan domisili Nasabah
                                        tempat penyelesaian dalam hal terjadi perselisihan.<br>
                                        <strong>Daftar Kantor (Pilih salah satu) :</strong>
                                        <select name="data[RealAccountStepFife][branch_id_1]" class="s51-branch_id"
                                                id="RealAccountStepFifeBranchId1">
                                            <option value="">&#45;&#45; Pilih Kantor Cabang &#45;&#45;</option>
                                            <option value="2" disabled>Kantor Cabang</option>
                                            <option value="1">Kantor Pusat</option>
                                        </select>
                                    </li>
                                    {% else %}
                                    <li>Apabila Perselisihan dan perbedaan pendapat yang timbul tidak dapat diselesaikan
                                        melalui cara sebagaimana dimaksud pada angka (1) dan angka (2), maka Para Pihak
                                        sepakat untuk menyelesaikan perselisihan melalui :
                                        <br>

                                        {% if userDatas.open_account_info.confirm.programme === "1" %}
                                        <label class="radio">
                                            <input type="radio"
                                                   name="data[RealAccountStepFife][settlement_of_disputes_1]"
                                                   id="RealAccountStepFifeSettlementOfDisputes1Bakti"
                                                   class="s51-settlement_of_disputes" value="1"
                                                   checked
                                            >Badan Arbitrase
                                            Perdagangan Berjangka Komoditi (BAKTI) berdasarkan Peraturan dan Prosedur
                                            BAKTI ;
                                        </label>
                                        <label class="radio">
                                            <input type="radio"
                                                   name="data[RealAccountStepFife][settlement_of_disputes_1]"
                                                   id="RealAccountStepFifeSettlementOfDisputes1PengadilanNegeri"
                                                   class="s51-settlement_of_disputes" value="2">Pengadilan
                                            Negeri
                                        </label>
                                        <input name="data[RealAccountTradeExperience][account_number]"
                                               class="form-control" maxlength="64" type="text"
                                               id="RealAccountSfftForm24PengadilanNegeri"
                                               required="required" aria-required="true"
                                        >
                                    </li>
                                    <li>Kantor atau kantor cabang Pialang Berjangka terdekat dengan domisili Nasabah
                                        tempat penyelesaian dalam hal terjadi perselisihan.<br>
                                        <strong>Daftar Kantor (Pilih salah satu) :</strong>
                                        <select name="data[RealAccountStepFife][branch_id_1]" class="s51-branch_id"
                                                id="RealAccountStepFifeBranchId1">
                                            <option value="">&#45;&#45; Pilih Kantor Cabang &#45;&#45;</option>
                                            <option value="2" disabled>Kantor Cabang</option>
                                            <option value="1">Kantor Pusat</option>
                                        </select>
                                    </li>
                                    {% else %}
                                    <label class="radio">
                                        <input type="radio"
                                               name="data[RealAccountStepFife][settlement_of_disputes_1]"
                                               id="RealAccountStepFifeSettlementOfDisputes1Bakti"
                                               class="s51-settlement_of_disputes" value="1"
                                        >Badan Arbitrase
                                        Perdagangan Berjangka Komoditi (BAKTI) berdasarkan Peraturan dan Prosedur
                                        BAKTI ;
                                    </label>
                                    <label class="radio">
                                        <input type="radio"
                                               name="data[RealAccountStepFife][settlement_of_disputes_1]"
                                               id="RealAccountStepFifeSettlementOfDisputes1PengadilanNegeri"
                                               class="s51-settlement_of_disputes" value="2"
                                               checked
                                        >Pengadilan
                                        Negeri
                                    </label>
                                    <input name="data[RealAccountTradeExperience][account_number]"
                                           class="form-control" maxlength="64" type="text"
                                           id="RealAccountSfftForm24PengadilanNegeri"
                                           required="required" aria-required="true"
                                           value="{{ userDatas.open_account_info.confirm.court }} "
                                    >
                                    </li>
                                    <li>Kantor atau kantor cabang Pialang Berjangka terdekat dengan domisili Nasabah
                                        tempat penyelesaian dalam hal terjadi perselisihan.<br>
                                        <strong>Daftar Kantor (Pilih salah satu) :</strong>
                                        <select name="data[RealAccountStepFife][branch_id_1]"
                                                class="s51-branch_id"
                                                disabled
                                                id="RealAccountStepFifeBranchId1">
                                            <option value="">&#45;&#45; Pilih Kantor Cabang &#45;&#45;</option>
                                            <option value="2" disabled>Kantor Cabang</option>
                                            <option value="1" selected>Kantor Pusat</option>
                                        </select>
                                    </li>
                                    {% endif %}
                                    {% endif %}

                                </ol>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm23ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][23][read_and_understand]"
                                           data-index="23"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm23ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>25</td>
                            <td colspan="2">
                                <strong>
                                    <b>Bahasa</b>
                                </strong>
                                <b><p>Perjanjian ini dibuat dalam Bahasa Indonesia..</p></b>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="3" class="text-right warning">
                                <div class="confirmation-verify">
                                    <strong>
                                        <em>
                                            <label for="RealAccountSffoForm24ReadAndUnderstand">
                                                Saya sudah membaca dan memahami
                                                <span class="warninginfo">This field is required.</span>
                                            </label>
                                        </em>
                                    </strong>
                                    <input type="checkbox"
                                           name="data[RealAccountSffoForm][24][read_and_understand]"
                                           data-index="24"
                                           class="107BPK051-checkbox 107BPK05-checkbox form-s45-checkbox"
                                           value="1"
                                           id="RealAccountSffoForm24ReadAndUnderstand">
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>


            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>Demikian Perjanjian Pemberian Amanat ini dibuat oleh Para Pihak dalam keadaan sadar, sehat
                        jasmani rohani dan tanpa unsur paksaan dari pihak manapun.
                    </p>
                    <p class="text-center"><strong>"Saya telah membaca, mengerti dan setuju terhadap semua ketentuan
                        yang tercantum dalam perjanjian ini".</strong></p>

                    <p class="text-center">Dengan mengisi kolom "YA" di bawah, saya menyatakan bahwa saya telah
                        menerima</p>

                    <p class="text-center hidden 107BPK051"><strong>"PERJANJIAN PEMBERIAN AMANAT TRANSAKSI KONTRAK
                        BERJANGKA"</strong></p>
                    <p class="text-center 107BPK052 show"><strong>"PERJANJIAN PEMBERIAN AMANAT TRANSAKSI KONTRAK
                        DERIVATIF"</strong></p>
                    <p class="text-center 107BPK052 show"><strong>"SISTEM PERDAGANGAN ALTERNATIF"</strong></p>



                    <p class="text-center">
                        mengerti dan juga menyetujui isinya.
                    </p>
                    <p>&nbsp;</p>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="RealAccountWizardTab7">
            <div class="row">
                <div class="col-md-12 col-sm-12" id="RealAccountTradingRules">
                    <div class="alert alert-danger alert-dismissible">THIS TRADING RULES IS ONLY APPLIED FOR
                        INDONESIAN CLIENT.<br> FOR OVERSEAS CLIENT, PLEASE CONTACT YOUR LOCAL AGENT OR CONTACT
                        US AT EMAIL csonline@rtfgroups.com.
                    </div>
                    <p style="text-align: right;"><em><strong>Efektif dari Tanggal&nbsp;30&nbsp;April
                        2018</strong></em></p>
                    <h2 style="text-align: center;"><strong>Trading Rules untuk Pro iTrading Platform</strong>
                        <br><strong>Forex, LLG, Silver, Indeks Futures Asia, Indeks Rollover &amp; Crude Oil
                            Rollover</strong></h2>
                    <table style="width: 100%;" border="1">
                        <tbody>
                        <tr style="height: 13px;">
                            <td style="width: 25%; height: 13px;"><strong>Produk</strong></td>
                            <td style="text-align: center; height: 13px;"><strong>USD/JPY</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="2"><strong>USD/CHF</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="2"><strong>EUR/USD</strong>
                            </td>
                            <td style="text-align: center; height: 13px;"><strong>GBP/USD</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3"><strong>AUD/USD</strong>
                            </td>
                            <td style="text-align: center; height: 13px;"><strong>NZD/USD</strong></td>
                            <td style="text-align: center; height: 13px;"><strong>USD/CAD</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Besaran Kontrak</strong></td>
                            <td style="text-align: center; height: 13px;">USD 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">USD 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">EUR 100,000</td>
                            <td style="text-align: center; height: 13px;">GBP 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="3">AUD 100,000</td>
                            <td style="text-align: center; height: 13px;">NZD 100,000</td>
                            <td style="text-align: center; height: 13px;">USD 100,000</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Produk</strong></td>
                            <td style="text-align: center; height: 13px;"><strong>GBP/JPY</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="2"><strong>EUR/JPY</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="2"><strong>AUD/JPY</strong>
                            </td>
                            <td style="text-align: center; height: 13px;"><strong>CHF/JPY</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3"><strong>EUR/GBP</strong>
                            </td>
                            <td style="text-align: center; height: 13px;"><strong>LLG</strong></td>
                            <td style="text-align: center; height: 13px;"><strong>Silver</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Besaran Kontrak</strong></td>
                            <td style="text-align: center; height: 13px;">GBP 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">EUR 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">AUD 100,000</td>
                            <td style="text-align: center; height: 13px;">CHF 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="3">EUR 100,000</td>
                            <td style="text-align: center; height: 13px;">100 Troy Ounces</td>
                            <td style="text-align: center; height: 13px;">5000 Troy Ounces</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Nilai kurs tukar tetap</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="11"><strong>USD 1- = Rp.
                                12.000,-</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Minimum tick</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="11">1 pip (FX) / USD 0.10
                                (LLG) / USD 0.01 (Silver)
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 78px;" rowspan="6"><strong>Minimum spread Bid / Ask</strong>
                                <strong><em>(Situasi pasar </em><em>n</em><em>ormal)</em></strong></td>
                            <td style="text-align: center; height: 13px;" colspan="4">
                                <strong><u>Produk</u></strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3"><strong><u>Transaksi
                                Online</u></strong></td>
                            <td style="text-align: center; height: 13px;" colspan="4"><strong><u>Transaksi
                                Telepon</u></strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>EUR/USD, USD/CHF,
                                NZD/USD, USD/CAD</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3">3 pips</td>
                            <td style="text-align: center; height: 13px;" colspan="4">6 pips</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>USD/JPY, GBP/USD,
                                AUD/USD</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3">2 pips</td>
                            <td style="text-align: center; height: 13px;" colspan="4">6 pips</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>EUR/JPY, AUD/JPY,
                                CHF/JPY EUR/GBP, GBP/JPY</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3">4 pips</td>
                            <td style="text-align: center; height: 13px;" colspan="4">6 pips</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>LLG</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3">USD 0.40</td>
                            <td style="text-align: center; height: 13px;" colspan="4">USD 0.50</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>Silver</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="3">USD 0.05</td>
                            <td style="text-align: center; height: 13px;" colspan="4">USD 0.05</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan per lot</strong> <strong>(Day
                                &amp; Overnight trade)</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="11">Rp. 12.000.000,- / USD
                                1,000,- (FX &amp; LLG) <br>Rp. 36.000.000,- / USD 3,000,- (Silver)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan untuk posisi </strong>l<strong>ocking
                                per pasang</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="11">Rp. 2.400.000,- / USD
                                200,- (FX &amp; LLG) <br>Rp. 6.000.000,- / USD 500,- (<em>S</em>ilver)
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya komisi per lot</strong> <strong>Satu sisi
                                (One Way)</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="11">Rp. 300.000,- / USD
                                25,-
                            </td>
                        </tr>
                        <tr style="height: 16px;">
                            <td style="height: 33px;" rowspan="2"><strong>Waktu perdagangan FX</strong> <strong>(WIB) </strong><u>(Selama
                                pasar tutup</u> <u>transaksi akan berhenti</u> <u>sekitar 5 menit untuk</u> <u>aktivitas
                                day end</u>)
                            </td>
                            <td style="text-align: center; height: 16px;" colspan="2"><strong>Musim
                                Panas</strong></td>
                            <td style="text-align: center; height: 16px;" colspan="6">Senin 5:00am – Sabtu
                                4:00am
                            </td>
                            <td style="text-align: center; height: 16px;" colspan="3">Pasar Tutup Jam 4:00am
                                (Selasa – Sabtu)
                            </td>
                        </tr>
                        <tr style="height: 17px;">
                            <td style="text-align: center; height: 17px;" colspan="2"><strong>Musim
                                Dingin</strong></td>
                            <td style="text-align: center; height: 17px;" colspan="6">Senin 5:30am – Sabtu
                                5:00am
                            </td>
                            <td style="text-align: center; height: 17px;" colspan="3">Pasar Tutup Jam 5:00am
                                (Selasa – Sabtu)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 52px;" rowspan="2"><strong>Waktu Perdagangan LLG &amp; Silver
                                (WIB) (Senin - Jumat)</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="2"><strong>Musim
                                Panas</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="6">Pasar Buka Jam : 06:00am
                                (Senin) <br>Pasar Buka Jam : 05:00am (Selasa - Jumat)
                            </td>
                            <td style="text-align: center; height: 26px;" colspan="3">Pasar Tutup Jam : 04:00am
                                (Selasa - Sabtu)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="text-align: center; height: 26px;" colspan="2"><strong>Musim
                                Dingin</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="6">Pasar Buka Jam : 06:00am
                                (Senin - Jumat)
                            </td>
                            <td style="text-align: center; height: 26px;" colspan="3">Pasar Tutup Jam : 05:00am
                                (Selasa - Sabtu)
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table style="width: 100%;" border="1">
                        <tbody>
                        <tr style="height: 13px;">
                            <td style="width: 25%; height: 13px;"><strong>Indeks Rollover Asia</strong></td>
                            <td style="width: 25%; text-align: center; height: 13px;"><strong>Hang Seng
                                Indeks</strong></td>
                            <td style="width: 25%; text-align: center; height: 13px;"><strong>Nikkei
                                Indeks</strong></td>
                            <td style="width: 25%; text-align: center; height: 13px;"><strong>Kospi
                                Indeks</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Besaran kontrak</strong></td>
                            <td style="text-align: center; height: 13px;">HKD 50 x Indeks Future Rate</td>
                            <td style="text-align: center; height: 13px;">¥ 500 x Indeks Future Rate</td>
                            <td style="text-align: center; height: 13px;">KRW 500,000 x Indeks Future Rate</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Nilai Kurs Tukar Tetap</strong></td>
                            <td style="text-align: center; height: 13px;">HKD 1 = Rp. 1,000</td>
                            <td style="text-align: center; height: 13px;">¥ 1 = Rp. 100-</td>
                            <td style="text-align: center; height: 13px;">KRW 1 = Rp. 10-</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Value Per Indeks Point</strong></td>
                            <td style="text-align: center; height: 13px;">Rp. 50,000-</td>
                            <td style="text-align: center; height: 13px;">Rp. 50,000-</td>
                            <td style="text-align: center; height: 13px;">Rp. 50,000</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Minimum tick</strong></td>
                            <td style="text-align: center; height: 13px;">1 indeks point</td>
                            <td style="text-align: center; height: 13px;">5 indeks points</td>
                            <td style="text-align: center; height: 13px;">0.05 indeks point</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Spread minimum Bid / Ask</strong> <strong>(<em>Situasi
                                Pasar </em><em>N</em><em>ormal</em>)</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="3" width="553">5 pips
                                (Transaksi Online) / 10 pips (Transaksi Telepon)
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Margin dibutuhkan per lot</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3" width="553">Rp.
                                10.000.000,- / USD 1,000,- (Day Trade) <br>Rp. 20.000.000,- / USD 2,000,-
                                (Overnight Trade)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan untuk</strong> <strong>posisi
                                locking per pasang</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="3" width="553">Rp.
                                1.000.000,- / USD 100,-
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya komisi per lot</strong> <strong>Satu sisi
                                (One Way)</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3" width="553">Rp. 250.000,-
                                / USD 25,-
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Waktu perdagangan (WIB) Senin - Jumat</strong>
                            </td>
                            <td style="text-align: center; height: 26px;">I. 08:15am – 11:00am <br>II. 12:00pm –
                                03:30pm
                            </td>
                            <td style="text-align: center; height: 26px;">I. 06:30am – 01:25pm <br>II. 01:55pm –
                                03:45am
                            </td>
                            <td style="text-align: center; height: 26px;">07:00am – 01:35pm</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Bulan kontrak</strong></td>
                            <td style="text-align: center; height: 13px;">Setiap Bulan</td>
                            <td style="text-align: center; height: 13px;" colspan="2" width="372">Maret, Juni,
                                September &amp; Desember
                            </td>
                        </tr>
                        <tr style="height: 65px;">
                            <td style="height: 65px;"><strong>Bulan penyesuaian untuk hari perdagangan gulir
                                (rollover)</strong></td>
                            <td style="height: 65px; text-align: justify;">2 hari kerja terakhir sebelum bulan
                                kontrak lama berakhir. Jika hari tersebut tidak ada hari perdagangan, maka hari
                                sebelumnya akan menjadi hari untuk bulan penyesuaian perdagangan.
                            </td>
                            <td style="height: 65px; text-align: justify;" colspan="2">1 hari kerja sebelum hari
                                Kamis pada minggu ke-2 bulan kontrak. Jika hari tersebut tidak ada hari
                                perdagangan, maka hari sebelumnya akan menjadi hari untuk bulan penyesuaian
                                perdagangan.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Referensi patokan harga</strong> <strong>gulir
                                (rollover)</strong></td>
                            <td style="height: 26px; text-align: justify;" colspan="3">Referensi patokan harga
                                menggunakan bulan kontrak lama sampai 1 hari kerja sebelum bulan kontrak lama
                                berakhir. Selanjutnya, referensi patokan harga menggunakan bulan kontrak baru
                                pada hari bulan kontrak lama berakhir.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Rumus perhitungan penyesuaian profit &amp; loss
                                gulir (rollover)</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="3"><strong>Posisi
                                Beli:</strong> (Harga penutupan bulan kontrak lama – Harga penutupan bulan
                                kontrak baru) x Besaran kontrak x Lots <br><strong>Posisi Jual:</strong> (Harga
                                penutupan bulan kontrak baru – Harga penutupan bulan kontrak lama) x Besaran
                                kontrak x Lots
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya gulir (Rollover fee)</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3">Tidak ada biaya rollover
                                (Rp. 0-)
                            </td>
                        </tr>
                        <tr style="height: 39px;">
                            <td style="height: 39px;"><strong>Perlindungan kisaran perdagangan untuk Indeks
                                Gulir Asia (Open Gap)</strong></td>
                            <td style="height: 39px; text-align: justify;" colspan="3">Semua posisi yang
                                menginap (overnight position) untuk Indeks Rollover Asia akan dilikuidasi secara
                                otomatis ketika harga pembukaan (Pembukaan harga BID &amp; Pembukaan harga ASK)
                                bergerak 300 points dari harga penutupan sebelumnya (Penutupan harga BID &amp;
                                Penutupan harga ASK). Hanya posisi locking yang tidak terpengaruh.
                            </td>
                        </tr>
                        <tr style="height: 130px;">
                            <td style="height: 130px;"><strong>Pergerakan Harga untuk</strong> <strong>Indeks
                                Nikkei</strong></td>
                            <td style="height: 130px; text-align: justify;" colspan="3">
                                <table style="width: 100%;" border="0">
                                    <tbody>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td><strong>Batas Harga Awal</strong></td>
                                        <td><strong>Batas Harga Tengah</strong></td>
                                        <td><strong>Batas Harga Akhir</strong></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Dibawah 7.000 points</strong></td>
                                        <td>+/- 1.000</td>
                                        <td>+/- 1.500 points</td>
                                        <td>+/- 2.000 points</td>
                                    </tr>
                                    <tr>
                                        <td><strong>7.000 points sampai dibawah 10.000 points</strong></td>
                                        <td>N.A.</td>
                                        <td>+/- 1.500 points</td>
                                        <td>+/- 2.000 points</td>
                                    </tr>
                                    <tr>
                                        <td><strong>10.000 points keatas</strong></td>
                                        <td>N.A.</td>
                                        <td>N.A.</td>
                                        <td>+/- 2.000 points</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <p>Setiap kali batas harga awal dan / atau tengah yang tercapai, masa tenang
                                    sepuluh menit akan dilaksanakan selama perdagangan terbatas pada batas harga
                                    yang berlaku. Setelah masa tenang, batas harga yang akan dikeluarkan akan
                                    diperluas dengan batas harga yang berlaku berikutnya (tengah atau akhir).
                                    Tidak akan ada perdagangan dalam setiap kontrak diluar batas harga akhir
                                    untuk sisa hari perdagangan. Bursa akan memulai sinyal dimulainya masa
                                    tenang ketika ada permintaan yang tidak memuaskan atau penawaran pada batas
                                    harga atas yang berlaku atau batas harga yang lebih rendah masing-masing
                                    untuk jangka waktu terus menerus lebih dari sepuluh detik. Bursa menggunakan
                                    kebijakannya untuk memperhitungkan faktor-faktor lain dipasar dalam
                                    menentukan dimulainya masa tenang. Berkaitan dengan sesi T+1, harga
                                    settlement harian diperoleh dalam sesi T yang baru saja berakhir yang akan
                                    menjadi harga acuan untuk menentukan batas harga.</p>
                            </td>
                        </tr>
                        <tr style="height: 143.469px;">
                            <td style="height: 143.469px;"><strong>Batas Pergerakan Harga untuk Indeks
                                Kospi</strong></td>
                            <td style="height: 143.469px; text-align: justify;" colspan="3">Pemberhentian
                                perdagangan akan diberlakukan apabila terjadi penurunan harga Indeks Kospi lebih
                                dari 8%, 15%, dan 20% dari harga penutupan hari sebelumnya, jika kondisi
                                tersebut berlangsung selama 1 menit, perdagangan Indeks Kospi akan
                                diberhentikan. Ketika Indeks Kospi mengalami penurunan lebih dari 8% dari harga
                                penutupan sebelumnya, tahap pertama penghentian akan dimulai. Setelah itu,
                                apabila Indeks Kospi mengalami penurunan kembali lebih dari 15% dari harga
                                penutupan sebelumnya dan terjadi 1% penurunan tambahan dibandingkan dengan harga
                                Indeks pada tahap 1, maka penghentian tahap 2 akan diberlakukan. Apabila tahap 1
                                dan 2 telah terjadi, perdagangan Indeks Kospi akan diberhentikan selama 20
                                menit. Penerapan dari setiap tahap adalah terbatas sekali dalam satu hari dan
                                untuk melindungi waktu dalam menentukan harga penutupan pasar, penghentian
                                tersebut tidak diberlakukan selama 40 menit sebelum penutupan pasar. Setelah
                                tahap 2 diberlakukan, apabila Indeks Kospi masih mengalami penurunan lebih dari
                                20% dari harga penutupan sebelumnya dan terjadi 1% penurunan tambahan
                                dibandingkan dengan harga Indeks pada tahap 2, semua perdagangan Indeks Kospi
                                akan dihentikan. Seperti pada tahap 2 adalah mungkin akan diberlakukan bahkan
                                setelah 40 menit sebelum penutupan pasar.&nbsp;
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table style="width: 100%;" border="1">
                        <tbody>
                        <tr>
                            <td style="width: 25%;"><strong>Indeks Rollover Amerika</strong></td>
                            <td style="width: 25%; text-align: center;"><strong>Dow Jones Indeks</strong></td>
                            <td style="width: 25%; text-align: center;"><strong>S&amp;P 500 Indeks</strong></td>
                            <td style="text-align: center;" width="172"><strong>Nasdaq Indeks</strong></td>
                        </tr>
                        <tr>
                            <td><strong>Besaran kontrak</strong></td>
                            <td style="text-align: center;">USD 5 x Indeks Future Rate</td>
                            <td style="text-align: center;">USD 50 x Indeks Future Rate</td>
                            <td style="text-align: center;" width="172">USD 20 x Indeks Future Rate</td>
                        </tr>
                        <tr>
                            <td><strong>Nilai Kurs Tukar Tetap</strong></td>
                            <td style="text-align: center;">USD 1 = Rp. 10,000-</td>
                            <td style="text-align: center;">USD 1 = Rp. 10,000</td>
                            <td style="text-align: center;" width="172">USD 1 = Rp. 10,000-</td>
                        </tr>
                        <tr>
                            <td><strong>Value Per Indeks Point</strong></td>
                            <td style="text-align: center;">Rp. 50,000,- / USD 5,-</td>
                            <td style="text-align: center;">Rp. 500,000- / USD 50,-</td>
                            <td style="text-align: center;" width="172">Rp. 200,000- / USD 20,-</td>
                        </tr>
                        <tr>
                            <td><strong>Minimum tick</strong></td>
                            <td style="text-align: center;">1 indeks point</td>
                            <td style="text-align: center;">0.25 indeks point</td>
                            <td style="text-align: center;" width="172">0.25 indeks point</td>
                        </tr>
                        <tr>
                            <td><strong>Spread minimum Bid / Ask</strong> <strong>(<em>Situasi
                                pasar </em><em>n</em><em>ormal</em>)</strong></td>
                            <td style="text-align: center;">5 indeks points (Transaksi Online) 10 indeks points
                                (Transaksi Telepon)
                            </td>
                            <td style="text-align: center;">0.50 indeks points (Transaksi Online) 1 indeks
                                points (Transaksi Telepon)
                            </td>
                            <td style="text-align: center;" width="172">1 indeks points (Transaksi Online &amp;
                                Telepon)
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Margin dibutuhkan per lot</strong> <strong>(Day &amp; overnight
                                trade)</strong></td>
                            <td style="text-align: center;">Rp. 20.000.000,- / USD 2,000,-</td>
                            <td style="text-align: center;">Rp. 25.000.000,- / USD 2,500,-</td>
                            <td style="text-align: center;" width="172">Rp. 20.000.000,- / USD 2,000,-</td>
                        </tr>
                        <tr>
                            <td><strong>Margin dibutuhkan untuk posisi locking per pasang</strong></td>
                            <td style="text-align: center;" colspan="3" width="544">Rp. 2.000.000- / USD
                                2,00,-
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Biaya komisi per lot</strong> <strong>Satu sisi (One Way)</strong></td>
                            <td style="text-align: center;" colspan="3" width="544">Rp. 250.000,- / USD 25,-
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Waktu perdagangan</strong> <strong>(WIB) (Senin – Jumat)</strong></td>
                            <td style="text-align: center;" colspan="3" width="544">06:00am – 04:15am (Musim
                                Dingin) <br>05:00am – 03:15am (Musim Panas)
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Bulan kontrak</strong></td>
                            <td style="text-align: center;" colspan="3" width="544">Maret, Juni, September &amp;
                                Desember
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Bulan penyesuaian untuk hari perdagangan gulir (rollover)</strong></td>
                            <td style="text-align: justify;" colspan="3" width="544">2 hari kerja sebelum Jumat
                                minggu ke-3 bulan kontrak lama. Jika pada hari tersebut tidak ada hari
                                perdagangan maka hari sebelumnya akan menjadi hari untuk bulan penyesuaian
                                perdagangan.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Referensi patokan harga gulir (rollover)</strong></td>
                            <td style="text-align: center;" colspan="3" width="544">Referensi patokan harga
                                menggunakan bulan kontrak lama sampai 2 hari kerja sebelum Jumat minggu ke- 3
                                bulan kontrak lama berakhir. Selanjutnya, referensi patokan harga menggunakan
                                bulan kontrak baru
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Rumus perhitungan penyesuaian profit &amp; loss gulir
                                (rollover)</strong></td>
                            <td style="text-align: center;" colspan="3" width="544"><strong>Posisi
                                Beli:</strong> (Harga penutupan bulan kontrak lama – Harga penutupan bulan
                                kontrak baru) x Besaran kontrak x Lots <br><strong>Posisi Jual:</strong> (Harga
                                penutupan bulan kontrak baru – Harga penutupan bulan kontrak lama) x Besaran
                                kontrak x Lots
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Biaya gulir (rollover fee)</strong></td>
                            <td style="text-align: center;" colspan="3" width="544">Tidak ada biaya rollover
                                (Rp. 0-)
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Batas pergerakan harga untuk Indeks Gulir Amerika (rollover)</strong>
                            </td>
                            <td style="text-align: justify;" colspan="3" width="544">7% (Level 1), 13% (Level
                                2), and 20% (Level 3) batas harga yang efektif adalah dari 8:30pm – 3:00am
                                <strong>(WIB) </strong>Senin sampai Sabtu. 5% batas atas dan bawah yang efektif
                                adalah dari 5:00am - 8:30pm <strong>(WIB) </strong>Senin sampai Jumat; dan
                                3:00am - 3:15am <strong>(WIB) </strong>Selasa sampai Sabtu. Antara 3:00am -
                                3:15am <strong>(WIB) </strong>batasan harga 5% tersebut tidak diberlakukan untuk
                                batas akhir harian 20%. <strong>**Semua waktu perdagangan berdasarkan waktu
                                    musim panas.</strong></td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table style="width: 100%;" border="1">
                        <tbody>
                        <tr style="height: 13px;">
                            <td style="width: 25%; height: 13px;"><strong>Produk Rollover</strong></td>
                            <td style="width: 25%; height: 13px; text-align: center;"><strong>FTSE
                                Indeks</strong></td>
                            <td style="width: 25%; height: 13px; text-align: center;"><strong>DAX
                                Indeks</strong></td>
                            <td style="width: 25%; height: 13px; text-align: center;"><strong>Crude Oil</strong>
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Besaran kontrak</strong></td>
                            <td style="height: 13px; text-align: center;">USD 15 x Indeks Future Rate</td>
                            <td style="height: 13px; text-align: center;">USD 30 x Indeks Future Rate</td>
                            <td style="height: 13px; text-align: center;">1,000 Barrel</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Nilai Kurs Tukar Tetap</strong></td>
                            <td style="height: 13px; text-align: center;">USD 1 = Rp. 10,000-</td>
                            <td style="height: 13px; text-align: center;">USD 1 = Rp. 10,000-</td>
                            <td style="height: 13px; text-align: center;">Rp. 12,000- / Floating USD</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Value Per Indeks Point</strong></td>
                            <td style="height: 13px; text-align: center;">Rp. 150,000- / USD 15,-</td>
                            <td style="height: 13px; text-align: center;">Rp. 300,000- / USD 30,-</td>
                            <td style="height: 13px; text-align: center;">N/A</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Minimum tick</strong></td>
                            <td style="height: 13px; text-align: center;">0.50 indeks point</td>
                            <td style="height: 13px; text-align: center;">0.50 indeks point</td>
                            <td style="height: 13px; text-align: center;">USD 0.01</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Spread minimum Bid / Ask</strong> <strong>(<em>Situasi
                                pasar </em><em>n</em><em>ormal</em>)</strong></td>
                            <td style="height: 26px; text-align: center;">2 indeks points (Transaksi Online
                                &amp; Telepon)
                            </td>
                            <td style="height: 26px; text-align: center;">2 indeks points (Transaksi Online
                                &amp; Telepon)
                            </td>
                            <td style="height: 26px; text-align: center;">USD 0.05 (Transaksi Onlline) <br>USD
                                0.10 (Transaksi Telepon)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan per lot</strong> <strong>(Day
                                &amp; Overnight trade)</strong></td>
                            <td style="height: 26px; text-align: center;">Rp. 20.000.000- / USD 2,000,-</td>
                            <td style="height: 26px; text-align: center;">Rp. 50.000.000,- / USD 5,000,-</td>
                            <td style="height: 26px; text-align: center;">Rp. 30.000.000,- / USD 2,500,-</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan untuk posisi locking per
                                pasang</strong></td>
                            <td style="height: 26px; text-align: center;" colspan="2" width="370">Rp.
                                2.000.000,- / USD 200,-
                            </td>
                            <td style="height: 26px; text-align: center;">Rp. 2.400.000,- / USD 200,-</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya komisi per lot</strong> <strong>Satu sisi
                                (One Way)</strong></td>
                            <td style="height: 13px; text-align: center;" colspan="2" width="370">Rp. 250.000,-
                                / USD 25,-
                            </td>
                            <td style="height: 13px; text-align: center;">Rp. 300.000,- / USD 25,-</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Waktu perdagangan (WIB) (Senin - Jumat)</strong>
                            </td>
                            <td style="height: 26px; text-align: center;"><strong>14:01 – 04:00 (Musim
                                Dingin)</strong> <br><strong>13:01 – 03:00 (Musim Panas)</strong></td>
                            <td style="height: 26px; text-align: center;"><strong>14:00 – 04:00 (Musim
                                Dingin)</strong> <br><strong>13:00 – 03:00 (Musim Panas)</strong></td>
                            <td style="height: 26px; text-align: center;"><strong>06:00 – 05:00 (Musim
                                Dingin)</strong> <br><strong>05:00 – 04:00 (Musim Panas)</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Bulan kontrak</strong></td>
                            <td style="height: 13px; text-align: center;" colspan="2" width="370">Maret, Juni,
                                September &amp; Desember
                            </td>
                            <td style="height: 13px; text-align: center;">Setiap Bulan</td>
                        </tr>
                        <tr style="height: 65px;">
                            <td style="height: 65px;"><strong>Bulan penyesuaian untuk hari perdagangan gulir
                                (rollover)</strong></td>
                            <td style="height: 65px; text-align: justify;" colspan="2" width="370">2 hari kerja
                                sebelum Jumat minggu ke-3 bulan kontrak lama. Jika pada hari tersebut tidak ada
                                hari perdagangan maka hari sebelumnya akan menjadi hari untuk bulan penyesuaian
                                perdagangan.
                            </td>
                            <td style="height: 65px; text-align: justify;">5 hari kerja sebelum tanggal 25 dari
                                bulan kontrak lama. Jika pada hari tersebut tidak ada hari perdagangan, maka
                                hari sebelumnya akan menjadi hari untuk bulan penyesuaian perdagangan.
                            </td>
                        </tr>
                        <tr style="height: 78px;">
                            <td style="height: 78px;"><strong>Referensi patokan harga gulir (rollover)</strong>
                            </td>
                            <td style="height: 78px; text-align: justify;" colspan="2" width="370">Referensi
                                patokan harga menggunakan bulan kontrak lama sampai 2 hari kerja sebelum Jumat
                                minggu ke-3 bulan kontrak lama berakhir. Selanjutnya, referensi patokan harga
                                menggunakan bulan kontrak baru pada hari bulan kontrak lama berakhir.
                            </td>
                            <td style="height: 78px; text-align: justify;">Referensi patokan harga menggunakan
                                bulan kontrak lama sampai 5 hari kerja sebelum tanggal 25 dari bulan kontrak
                                lama berakhir. Selanjutnya referensi patokan harga menggunakan bulan kontrak
                                baru pada hari bulan kontrak lama berakhir.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Rumus perhitungan penyesuaian profit &amp; loss
                                gulir (rollover)</strong></td>
                            <td style="height: 26px; text-align: center;" colspan="3" width="550"><strong>Posisi
                                Beli:</strong> (Harga penutupan bulan kontrak lama – Harga penutupan bulan
                                kontrak baru) x Besaran kontrak x Lots <br><strong>Posisi Jual:</strong> (Harga
                                penutupan bulan kontrak baru – Harga penutupan bulan kontrak lama) x Besaran
                                kontrak x Lots
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya gulir (Rollover fee)</strong></td>
                            <td style="height: 13px; text-align: center;" colspan="3" width="550">Tidak ada
                                biaya rollover (Rp. 0-)
                            </td>
                        </tr>
                        <tr style="height: 52px;">
                            <td style="height: 52px;"><strong>Fluktuasi harga harian maksimum untuk Crude
                                Oil</strong></td>
                            <td style="height: 52px; text-align: justify;" colspan="3" width="550">$10.00 per
                                barrel ($10,000 per kontrak) untuk semua bulan. Jika kontrak apapun yang
                                diperdagangkan, bid atau offered pada batas selama lima menit, perdagangan akan
                                dihentikan selama 5 menit. ketika perdagangan dilanjutkan, batas tersebut
                                diperluas jadi $10.00 per barrel dikedua arah. Jika berhenti lagi yang dipicu,
                                pasar akan diperluas dengan $10,00 per barrel di kedua arah setelah setiap lima
                                menit berturut - turut perdagangan berhenti. Tidak akan ada batas fluktuasi
                                harga maksimum selama satu sesi perdagangan.
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Deposit awal</strong></td>
                            <td style="height: 13px; text-align: center;" colspan="3" width="550"><strong>Rp.
                                100.000.000,- / USD 10,000,-</strong></td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Bonus on effective margin</strong>
                                <strong>(BOE) </strong>(<strong>terima setiap jumat)</strong></td>
                            <td style="height: 26px; text-align: left;" colspan="3" width="550"><u>Efektif
                                margin terendah dalam seminggu X bunga tahunan (Rp = 3%) X 7 hari</u> 365 hari
                                <br>** <u>Untuk Floating USD Account tidak mendapat BOE</u> <br><strong>** <u>BOE
                                    hanya didapat apabila ada transaksi market order atau pos isi yang terbuka
                                    dalam</u></strong> <strong><u>1 minggu</u></strong></td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Order perdagangan</strong></td>
                            <td style="height: 26px; text-align: justify;" colspan="3" width="550">Semua order
                                diterima dan dilaksanakan dengan pengertian bahwa nasabah mampu menyelesaikan
                                transaksi dengan memegang dan / atau menyerahkan deposit margin.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table style="width: 100%;" border="1">
                        <tbody>
                        <tr>
                            <td style="width: 25%;">&nbsp; <strong>K</strong><strong>elebihan tansaksi</strong>
                                <strong>(Overtrading)</strong></td>
                            <td>&nbsp; Ketika order perdagangan melebihi batas limit dari open posisi yang
                                diperbolehkan &nbsp;melebihi&nbsp; &nbsp;effective margin, maka order
                                perdagangan tersebut akan dilikuidasi dengan spread (bid &amp; ask) tetapi tidak
                                dikenakan biaya komisi .
                            </td>
                        </tr>
                        <tr>
                            <td><strong>DQ quota (Maksimum)</strong></td>
                            <td>Maksimal 50 lots (Baru atau likuidasi) yang diperbolehkan untuk setiap sekali
                                DQ.
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp; &nbsp; <strong>Eksekusi Order</strong></td>
                            <td>Semua order harus ditempatkan melalui sistem TGF atau melalui telepon ke
                                dealing. Semua order yang diterima sesuai dengan kebijakan yang ada di TGF.
                                &nbsp;Order market akan dieksekusi di harga saat nasabah mengajukan dan
                                mengkonfirmasi order tersebut. Selama masa volatilitas, beberapa order mungkin
                                bisa ditolak oleh dealing dikarenakan perubahan harga yang sangat cepat.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Perubahan pada market order</strong></td>
                            <td>Setelah &nbsp;order &nbsp;dikonfirmasi &nbsp;oleh &nbsp;sistem &nbsp;perdagangan
                                &nbsp;TGF &nbsp;atau &nbsp;melalui &nbsp;telepon, &nbsp;<u>tidak &nbsp;diperbolehkan
                                    &nbsp;ada</u>
                                <u>p</u><u>e</u><u>r</u><u>u</u><u>b</u><u>a</u><u>h</u><u>a</u><u>n</u> detail
                                apapun pada market order termasuk nomor akun, posisi (beli atau jual, baru atau
                                likuidasi), produk trading, harga eksekusi, jumlah lot, bulan kontrak (trading
                                month).
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Pasang Limit order, Stop loss order &amp; O.C.O. order</strong></td>
                            <td>
                                <p>Maksimal &nbsp;50 lots (baru atau likuidasi) yang diterima untuk setiap limit
                                    order &amp; stop loss order. Orders dapat dipasang ketika harga market
                                    sekurang-kurangnya (10 pips untuk Forex / 30 pips untuk HSI, Nikkei, Kospi
                                    &amp; Dow Jones / 2 dollars untuk LLG / 7.5 points untuk S&amp;P &amp;
                                    Nasdaq / 15 points untuk FTSE &amp; DAX / 0.30 for CL &amp; Silver) dari
                                    harga yang diinginkan dan hanya setelah mendapat konfirmasi dari dealing
                                    office harga dapat diterima, contoh untuk order beli, harga yang diinginkan
                                    harus (10 pips untuk Forex / 30 pips untuk HSI, Nikkei, Kospi &amp; Dow
                                    Jones / 2 dollars untuk LLG / 7.5 points untuk S&amp;P &amp; Nasdaq / 15
                                    points untuk FTSE &amp; DAX / 0.30 untuk CL &amp; Silver) dari harga ask di
                                    layar monitor; dan untuk order jual, harga yang diinginkan harus (10 pips
                                    untuk Forex / 30 pips untuk HSI, Nikkei, Kospi &amp; Dow Jones / 2 dollars
                                    untuk LLG / 7.5 points untuk S&amp;P &amp; Nasdaq / 15 points untuk FTSE
                                    &amp; DAX / 0.30 untuk CL &amp; Silver) dari harga bid di layar monitor.
                                    Akan tetapi dealer dapat setiap waktu dengan kebijakannya sendiri dapat
                                    menerima atau menolak order tersebut.</p>
                                <p><strong>Semua Forex, LLG, Silver, Indeks Rollover &amp; Crude Oil Rollover
                                    tidak diperbolehkan memasang stop loss order untuk posisi baru kecuali
                                    likuidasi atau posisi locking.</strong> <strong><u>**Forex Telepon Trading
                                    untuk Limit Order, Stop Order &amp; OCO Order tetap sama dengan harga
                                    yang</u> <u>diinginkan harus 20 pips jauhnya dari harga yang ada di layar
                                    monitor selama pasar normal.**</u></strong></p>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Perubahan limit order</strong></td>
                            <td>
                                <p>Limit order dapat dirubah sebelum menjadi order ketika market pasar
                                    setidaknya (10 pips untuk Forex / 30 pips untuk HSI, Nikkei, Kospi &amp; Dow
                                    Jones / 2 dollars untuk LLG / 7.5 points untuk S&amp;P &amp; Nasdaq / 15
                                    points untuk FTSE &amp; DAX / 0.30 untuk CL &amp; Silver) dari harga yang
                                    diinginkan.</p>
                                <p><strong><u>**Forex Telepon Trading untuk Limit Order, Stop Order &amp; OCO
                                    Order tetap sama dengan harga yang</u> <u>diinginkan harus 20 pips jauhnya
                                    dari harga yang ada di layar monitor selama pasar normal.**</u></strong></p>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Pembatalan limit order</strong></td>
                            <td>
                                <ol>
                                    <li>Limit order dapat dibatalkan ketika harga limit belum di eksekusi dan
                                        hanya jika sistem perdagangan online TGF mengkonfirmasi pembatalan
                                        tersebut.
                                    </li>
                                    <li>Good Till Market Close (G.T.M.C): a. FX, LLG, Silver, CL, Indeks
                                        Rollover Amerika &amp; Eropa : Order akan berlaku pada hari tersebut dan
                                        penutupan pasar harian (good till daily). b. Indeks Asia (HSI, Nikkei
                                        &amp; Kospi): Order akan berlaku selama sesi perdagangan saja. Oleh
                                        karena itu, semua order G.T.M.C. akan dibatalkan setelah penutupan
                                        setiap sesi perdagangan.&nbsp;
                                    </li>
                                    <li>Good Till Friday (G.T.F): Order akan berlaku selama seminggu dan
                                        penutupan sampai Jumat (good till Friday). <strong><u>(Hanya untuk
                                            FX)</u></strong></li>
                                    <li>Limit Settle Order akan otomatis dibatalkan jika harga open posisi telah
                                        dilikuidasi atau salah.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Eksekusi limit order</strong></td>
                            <td>1. Harga yang diinginkan telah diquote oleh basis sistem on line TGF pada BID /
                                ASK. 2. Untuk <u>order beli</u> akan di eksekusi ketika harga ask pada layar
                                menyentuh harga yang diinginkan; dan <u>order jual</u> akan dieksekusi ketika
                                harga bid pada layar menyentuh harga yang diinginkan. 3. Order limit akan
                                diaktifkan oleh harga yang ditunjukkan oleh nasabah. Namun selama sesi volatil
                                yang ekstrems, eksekusi tersebut mungkin tidak dapat dilakukan dan slippage bisa
                                terjadi pada harga eksekusi oleh sistem perdagangan online TGF ini.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Market on close</strong> <strong>(MOC) order</strong></td>
                            <td>Order MOC harus dipasang hanya melalui telepon setidaknya 15 menit sebelum
                                penutupan pasar. FX MOC order hanya dapat dipasang pada hari Jumat atau hari
                                kerja sebelum pasar libur. Order beli (buy) dengan MOC berdasarkan pada
                                penutupan harga ASK. Order jual (sell) dengan MOC berdasarkan pada penutupan
                                harga BID. Order MOC untuk likuidasi akan otomatis dibatalkan jika harga posisi
                                terbuka telah dilikuidasi atau salah.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Margin call level</strong></td>
                            <td>Ketika efektif margin dibawah 70% dari margin yang diperlukan, nasabah akan
                                menerima pemberitahu an margin call melalui e-mail atau melalui telepon. Sebuah
                                akun dapat dianggap kekurangan margin setiap kali efektif margin kurang dari 70%
                                dari margin yang diperlukan selama penutupan pasar. TGF akan menutup posisi
                                nasabah dengan memakai harga penutupan (BID/ASK) dengan metode last-in-first out
                                (LIFO) sampai efektif margin mencukupi diatas ambang batas 70%. Ini dilakukan
                                atas dasar upaya terbaik dan TGF berhak untuk menutup salah satu atau semua
                                posisi nasabah.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table style="width: 100%;" border="1">
                        <tbody>
                        <tr>
                            <td style="width: 25%;"><strong>Cut loss level</strong></td>
                            <td style="text-align: justify;">Jika efektif margin di akun pada setiap saat turun
                                atau dibawah 20% dari margin yang diperlukan, TGF akan menutup semua posisi
                                nasabah dengan menggunakan harga cut loss (BID/ASK). Tergantung pada volatilitas
                                pasar, penutupan posisi nasabah mungkin akan terpengaruh dibawah ambang bata s
                                20% dan efektif margin pada akun bisa menjadi minus. Nasabah harus bertanggung
                                jawab terhadap jumlah efektif margin yang mengalami defisit.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Lain - lain (Miscellaneous)</strong></td>
                            <td style="text-align: justify;">
                                <ol>
                                    <li>TGF akan memberikan password pribadi kepada nasabah dan identifikasi
                                        user (bernama "Kode Akses"). Kode akses akan memungkinkan nasabah untuk
                                        mengakses akun dan memasukan order kedalam akun melalui sistem
                                        perdagangan online TGF ini. Nasabah harus menjaga kerahasiaan kode akses
                                        setiap saat. Nasabah menerima tanggung jawab penuh atas penggunaan dan
                                        perlindungan yang meliputi kode akses, namun tak terbatas pada semua
                                        order yang masuk ke sistem perdagangan online TGF yang menggunakan kode
                                        akses dan perubahan dalam informasi akun nasabah yang masuk menggunakan
                                        kode akses.
                                    </li>
                                    <li>Nasabah harus bertanggung jawab untuk selalu tetap meng-update status
                                        bapak / ibu terhadap akun transaksi (trading account) dan laporan
                                        hariannya (daily statements). 3. Semua instruksi yang terkait dengan
                                        akun nasabah dan prosedur perdagangan atau model transaksi selain
                                        petunjuk dalam perjanjian nasabah (Client Agreement) harus diserahkan
                                        kepada perusahaan secara tertulis saja. Tidak ada instruksi lisan yang
                                        diterima atau diakui.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Keluhan (Complaints)</strong></td>
                            <td>Jika ada perbedaan / perselisihan, dealer hanya akan menerima keluhan tidak
                                lebih dari 30 menit setelah perbedaan / perselisihan tersebut diungkapkan.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p style="text-align: justify;"><strong>Semua aturan perdagangan yang disebutkan diatas
                        diterapkan pada kondisi pasar normal saja. Oleh karena itu, ada subjek yang dapat
                        berubah dari waktu ke waktu dan aturan perdagangan yang baru bisa ditambahkan kapan
                        saja.</strong> <strong>Pengakuan untuk Real Time Futures</strong> Tanpa mengurangi
                        isi <strong>BUKU PERJANJIAN</strong>, Saya / Kami mengakui bahwa Saya / Kami telah
                        menerima dan bahwa Saya / Kami menerima TRADING RULES ini diberikan kepada Saya / Kami.
                    </p>
                    <p style="text-align: right;">&nbsp;</p>
                    <hr>
                    <h2 style="text-align: center;"><strong>Trading Rules untuk MT4 Trading
                        Platform<br></strong>Forex, LLG, Silver, Cruide Oil &amp;<br><strong>Indeks Futures
                        Asia, Rollover Asia, Amerika &amp; Eropa</strong></h2>
                    <table border="1">
                        <tbody>
                        <tr style="background-color: #999999; height: 13px;">
                            <td style="width: 25%; height: 13px;"><strong>Produk</strong></td>
                            <td style="text-align: center; height: 13px;">
                                <strong>U</strong><strong>SD/JPY</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="2"><strong>U</strong><strong>SD/CHF</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="2"><strong>EUR/USD</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="2"><strong>G</strong><strong>B</strong><strong>P/USD</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="3">
                                <strong>AUD</strong><strong>/USD</strong></td>
                            <td style="text-align: center; height: 13px;">
                                <strong>N</strong><strong>ZD/USD</strong></td>
                            <td style="text-align: center; height: 13px;">
                                <strong>U</strong><strong>SD/CAD</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;">
                                <strong>B</strong><strong>esaran </strong><strong>K</strong><strong>ontrak</strong>
                            </td>
                            <td style="text-align: center; height: 13px;">USD 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">USD 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">EUR 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">GBP 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="3">AUD 100,000</td>
                            <td style="text-align: center; height: 13px;">NZD 100,000</td>
                            <td style="text-align: center; height: 13px;">USD 100,000</td>
                        </tr>
                        <tr style="background-color: #999999; height: 13px;">
                            <td style="height: 13px;"><strong>Produk</strong></td>
                            <td style="text-align: center; height: 13px;">
                                <strong>G</strong><strong>B</strong><strong>P/JPY</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="2"><strong>EUR/JPY</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="2">
                                <strong>AUD</strong><strong>/JPY</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="2">
                                <strong>CH</strong><strong>F/JPY</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3"><strong>EUR/GBP</strong>
                            </td>
                            <td style="text-align: center; height: 13px;"><strong>LLG</strong></td>
                            <td style="text-align: center; height: 13px;"><strong>Silver</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;">
                                <strong>B</strong><strong>esaran </strong><strong>K</strong><strong>ontrak</strong>
                            </td>
                            <td style="text-align: center; height: 13px;">GBP 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">EUR 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">AUD 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="2">CHF 100,000</td>
                            <td style="text-align: center; height: 13px;" colspan="3">EUR 100,000</td>
                            <td style="text-align: center; height: 13px;">100 Troy Ounces</td>
                            <td style="text-align: center; height: 13px;">5000 Troy Ounces</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>N</strong><strong>ilai tukar kurs tetap</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="12">
                                <strong>U</strong><strong>SD 1- = Rp. </strong><strong>12.000,-</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>M</strong><strong>inimum tick</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="12">1 pip (FX) / USD 0.10
                                (LLG) / USD 0.01 (Silver)
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 91px;" rowspan="7"><strong>M</strong><strong>inimal spread Bid
                                / </strong><strong>A</strong><strong>sk</strong> <strong><em>(Situasi
                                pasar </em></strong><strong><em>n</em></strong><strong><em>ormal)</em></strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="4">
                                <strong><u>Produk</u></strong></td>
                            <td style="text-align: center; height: 13px;" colspan="5"><strong><u>Transaksi
                                Online</u></strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3"><strong><u>Transaksi
                                Telepon</u></strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>EUR/USD,
                                USD/CHF, </strong><strong>N</strong><strong>ZD/USD, </strong><strong>USD/CAD</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="5">3 pips</td>
                            <td style="text-align: center; height: 13px;" colspan="3">6 pips</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>U</strong><strong>SD/JPY,
                                GBP/USD, AUD/USD</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="5">2 pips</td>
                            <td style="text-align: center; height: 13px;" colspan="3">6 pips</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>EUR/JPY,
                                AUD/JPY, </strong><strong>C</strong><strong>H</strong><strong>F/JPY,
                                EUR/GBP</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="5">4 pips</td>
                            <td style="text-align: center; height: 13px;" colspan="3">6 pips</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>G</strong><strong>BP/JPY</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="5">4 pips</td>
                            <td style="text-align: center; height: 13px;" colspan="3">6 pips</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>LLG</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="5">USD 0.40</td>
                            <td style="text-align: center; height: 13px;" colspan="3">USD 0.50</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="text-align: center; height: 13px;" colspan="4"><strong>Silver</strong>
                            </td>
                            <td style="text-align: center; height: 13px;" colspan="5">USD 0.05</td>
                            <td style="text-align: center; height: 13px;" colspan="3">USD 0.05</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan per</strong> <strong>lot (Day
                                &amp; Overnight trade)</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="12">Rp. 12.000.000,- / USD
                                1,000- (FX &amp; LLG) <br>Rp. 36.000.000,- / USD 3,000- (Silver)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan untuk</strong>
                                <strong>posisi </strong>l<strong>ocking per pasang</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="12">Rp. 2.400.000,- / USD
                                200- (FX &amp; LLG) <br>Rp. 6.000.000,- / USD 500- (Silver)
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya komisi per Lot</strong> <strong>(Open
                                Only)</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="12">Rp. 600.000,- / USD 50-
                            </td>
                        </tr>
                        <tr style="height: 16px;">
                            <td style="height: 33px;" rowspan="2"><strong>Waktu perdagangan FX (WIB) </strong>(Transaksi
                                akan berhenti sekitar 5 menit untuk aktivitas day end selama pasar tutup)
                            </td>
                            <td style="width: 25%; height: 16px;" colspan="2"><strong>Musim Panas</strong></td>
                            <td style="width: 25%; height: 16px;" colspan="6">Senin 5:30am – Sabtu 4:00am</td>
                            <td style="height: 16px;" colspan="4">Pasar Tutup Jam 4:00am (Selasa – Sabtu)</td>
                        </tr>
                        <tr style="height: 17px;">
                            <td style="height: 17px;" colspan="2"><strong>Musim Dingin</strong></td>
                            <td style="height: 17px;" colspan="6">Senin 5:30am – Sabtu 5:00am</td>
                            <td style="height: 17px;" colspan="4">Pasar Tutup Jam 5:00am (Selasa – Sabtu)</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 39px;" rowspan="2"><strong>Waktu Perdagangan Gold &amp; Silver
                                (WIB) (Senin - Jumat)</strong></td>
                            <td style="height: 26px;" colspan="2"><strong>Musim Panas</strong></td>
                            <td style="height: 26px;" colspan="6">Pasar Buka Jam : 06:00am (Senin)<br>Pasar Buka
                                Jam : 05:00am (Selasa - Jumat)
                            </td>
                            <td style="height: 26px;" colspan="4">Pasar Tutup Jam : 04:00am (Selasa - Sabtu)
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;" colspan="2"><strong>Musim Dingin</strong></td>
                            <td style="height: 13px;" colspan="6">Pasar Buka Jam : 06:00am (Senin - Jumat)</td>
                            <td style="height: 13px;" colspan="4">Pasar Tutup Jam : 05:00am (Selasa - Sabtu)
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table border="1">
                        <tbody>
                        <tr style="background-color: #999999;">
                            <td style="width: 25%;"><strong>Produk Rollover</strong></td>
                            <td style="text-align: center;"><strong>Crude Oil</strong></td>
                        </tr>
                        <tr>
                            <td><strong>Besaran Kontrak</strong></td>
                            <td style="text-align: center;">1,000 Barrels</td>
                        </tr>
                        <tr>
                            <td><strong>Nilai kurs tukar tetap</strong></td>
                            <td style="text-align: center;">USD 1- = Rp. 12,000,- / Floating USD</td>
                        </tr>
                        <tr>
                            <td><strong>Minimum tick</strong></td>
                            <td style="text-align: center;">USD 0.01</td>
                        </tr>
                        <tr>
                            <td><strong>Minimal spread Bid / Ask</strong> <strong><em>(Situasi
                                pasar </em><em>n</em><em>ormal)</em></strong></td>
                            <td style="text-align: center;">USD 0.05 (Transaksi Online) / USD 0.10 (Transaksi
                                Telepon)
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Margin yang dibutuhkan per lot (Day &amp; overnight trade)</strong></td>
                            <td style="text-align: center;">Rp. 30.000.000,- / USD 2,500-</td>
                        </tr>
                        <tr>
                            <td><strong>Margin dibutuhkan untuk posisi </strong>l<strong>ocking per
                                pasang</strong></td>
                            <td style="text-align: center;">Rp. 2.400.000,- / USD 200-</td>
                        </tr>
                        <tr>
                            <td><strong>Biaya komisi per Lot</strong> <strong>(Open Only)</strong></td>
                            <td style="text-align: center;">Rp. 600.000,- / USD 50-</td>
                        </tr>
                        <tr>
                            <td><strong>Waktu perdagangan </strong>(<strong>WIB) (Senin - Jumat)</strong></td>
                            <td style="text-align: center;"><strong>06:00am – 05:00am (Musim
                                Dingin)<br></strong><strong>05:00am – 04:00am (Musim Panas)</strong></td>
                        </tr>
                        <tr>
                            <td><strong>Bulan kontrak</strong></td>
                            <td style="text-align: center;">Setiap Bulan</td>
                        </tr>
                        <tr>
                            <td><strong>Bulan penyesuaian untuk</strong> <strong>hari perdagangan gulir</strong>
                                <strong>(rollover)</strong></td>
                            <td>5 hari kerja sebelum tanggal 25 dari bulan kontrak lama. Jika hari tersebut
                                bukan hari perdagangan, maka hari sebelumnya akan menjadi hari untuk bulan
                                penyesuaian perdagangan.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Referensi patokan harga gulir (rollover)</strong></td>
                            <td>Referensi patokan harga menggunakan bulan kontrak lama sampai 5 hari kerja
                                sebelum tanggal 25 dari bulan kontrak lama berakhir. Selanjutnya referensi
                                patokan harga menggunakan bulan kontrak baru pada hari bulan kontrak lama
                                berakhir.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Rumus perhitungan penyesuaian profit &amp; loss gulir
                                (rollover)</strong></td>
                            <td><strong>Posisi Beli </strong>: (Harga penutupan bulan kontrak lama–Harga
                                penutupan bulan kontrak baru) x Besaran kontrak x Lots <br><strong>Posisi
                                    Jual:</strong> (Harga penutupan bulan kontrak baru–Harga penutupan bulan
                                kontrak lama) x Besaran kontrak x Lots
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Biaya gulir (rollover fee)</strong></td>
                            <td>Tidak ada biaya rollover (Rp. 0-)</td>
                        </tr>
                        <tr>
                            <td><strong>Harga fluktuasi harian maksimum untuk Crude Oil</strong></td>
                            <td>$10.00 per barrel ($10,000 per kontrak) untuk semua bulan. Jika kontrak apapun
                                yang diperdagangkan, bid, atau offered pada batas selama lima menit, perdagangan
                                akan dihentikan selama lima menit. Ketika perdagangan dilanjutkan, batas
                                tersebut diperluas jadi $10.00 per barrel dikedua arah. Jika berhenti lagi yang
                                dipicu, pasar akan diperluas dengan $10.00 per barrel dikedua arah setelah
                                setiap lima menit berturut-turut perdagangan berhenti. Tidak akan ada batas
                                fluktuasi harga maksimum selama satu sesi perdagangan.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table style="width: 100%;" border="1">
                        <tbody>
                        <tr style="background-color: #999999;">
                            <td style="width: 25%;"><strong>Index Futures Asia</strong></td>
                            <td style="width: 25%; text-align: center;"><strong>Hangseng Indeks</strong></td>
                            <td style="width: 25%; text-align: center;"><strong>Nikkei Indeks</strong></td>
                            <td style="width: 25%; text-align: center;"><strong>Kospi Indeks</strong></td>
                        </tr>
                        <tr>
                            <td><strong>Besaran Kontrak</strong></td>
                            <td style="text-align: center;">HKD 50 x Indeks Future Rate</td>
                            <td style="text-align: center;">¥ 500 x Indeks Future Rate</td>
                            <td style="text-align: center;">KRW 500,000 x Indeks Future Rate</td>
                        </tr>
                        <tr>
                            <td><strong>Nilai Kurs Tukar Tetap</strong><br><strong>**(Pilih salah Salah Satu
                                Saja)</strong></td>
                            <td style="text-align: center;">HKD 1 = Rp. 1,000 / (Rp. 50,000)</td>
                            <td style="text-align: center;">¥ 1 = Rp. 60- / (Rp. 30,000)<br>¥ 1 = Rp. 100- /
                                (Rp. 50,000)
                            </td>
                            <td style="text-align: center;">KRW 1 = Rp. 7- / (Rp. 35,000)<br>KRW 1 = Rp. 10- /
                                (Rp. 50,000)
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Minimum Tick</strong></td>
                            <td style="text-align: center;">1 indeks point</td>
                            <td style="text-align: center;">5 indeks point</td>
                            <td style="text-align: center;">0.05 indeks point</td>
                        </tr>
                        <tr>
                            <td><strong>Spread minimum Bid / Ask</strong> <strong>(<em>Situasi Pasar Normal</em>)</strong>
                            </td>
                            <td style="text-align: center;" colspan="3">5 pips (Transaksi Online) / 10 pips
                                (Transaksi Telepon)
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Margin dibutuhkan per lot </strong></td>
                            <td style="text-align: center;" colspan="3">USD 1,000,- / Rp. 10.000.000,- (Day
                                Trade) <br>USD 2,000,- / Rp. 20.000.000,- (Overnight Trade)
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Margin dibutuhkan untuk</strong> <strong>posisi locking per
                                pasang</strong></td>
                            <td style="text-align: center;" colspan="3">Rp. 1.000.000,- / USD 100,-</td>
                        </tr>
                        <tr>
                            <td><strong>Biaya komisi per lot</strong> <strong>satu sisi (One Way)</strong></td>
                            <td style="text-align: center;" colspan="3">Rp. 250.000,- / USD 25,-</td>
                        </tr>
                        <tr>
                            <td><strong>Waktu perdagangan (WIB) Senin - Jumat</strong></td>
                            <td style="text-align: center;">
                                <p>I. 08:15am – 11:00am<br>II. 12:00pm – 03:30pm</p>
                            </td>
                            <td style="text-align: center;">
                                <p>I. 06:30am – 01:25pm<br>II. 01:55pm – 03:45am</p>
                            </td>
                            <td style="text-align: center;">07:00am – 01:35pm</td>
                        </tr>
                        <tr>
                            <td><strong>Bulan kontrak</strong></td>
                            <td style="text-align: center;">Setiap Bulan</td>
                            <td style="text-align: center;" colspan="2">Maret, Juni, September &amp; Desember
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Hari pertama perdagangan</strong></td>
                            <td style="text-align: center;">Setiap tanggal 25 dibulan kontrak sebelumnya</td>
                            <td style="text-align: center;">Kamis minggu pertama dibulan kontrak sebelumnya</td>
                            <td style="text-align: center;">Senin minggu kedua dibulan kontrak sebelumnya</td>
                        </tr>
                        <tr>
                            <td rowspan="2"><strong>Waktu penutupan hariperdagangan terakhir untukbulan kontrak
                                sebelumnya (WIB) <em>(<u>hanya untuk posisi</u> </em><em><u>likuidasi)</u></em></strong>
                            </td>
                            <td style="text-align: center;">Hari kerja sebelum hari kerja<br>terakhir bulan
                                kontrak <br>sebelumnya<br>(Ditutup pada 03:00pm)
                            </td>
                            <td style="text-align: center;">Kamis minggu ke-2 bulan kontra sebelumnya
                                <strong><em>(</em><em>D</em><em>itutup
                                    pada </em><em>0</em><em>1</em><em>:</em><em>2</em><em>5</em><em>pm)</em></strong>
                            </td>
                            <td style="text-align: center;">Kamis minggu ke-2 bulan kontrak sebelumnya
                                <strong><em>(</em><em>D</em><em>itutup
                                    pada </em><em>1</em><em>3</em><em>:</em><em>2</em><em>0</em><em>pm</em><em>)</em></strong>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">Semua kontrak Indeks Futures Asia akan diselesaikan pada atau
                                sebelum pasar tutup dihari perdagangan terakhir. Semua posisi terbuka akan
                                dilikuidasi oleh order MOC pada hari perdagangan terakhir setelah pasar tutup.
                                Order beli akan di likuidasi MOC berdasarkan pada penutupan harga ASK. Order
                                jual akan dilikuidasi oleh MOC berdasarkan pada penutupan harga BID.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Perlindungan kisaran perdagangan untuk Indeks Futures Asia (Open
                                Gap)</strong></td>
                            <td colspan="3">Semua posisi yang menginap (overnight position) untuk Indeks Futures
                                Asia akan dilikuidasi secara otomatis ketika harga pembukaan (Pembukaan harga
                                BID &amp; Pembukaan harga ASK) bergerak 300 points dari harga penutupan
                                sebelumnya (Penutupan harga BID &amp; Penutupan harga ASK). Hanya posisi locking
                                yang tid ak terpengaruh.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Batas Pergerakan Harga untuk Indeks Nikkei</strong></td>
                            <td colspan="3">
                                <table style="width: 100%;" border="0">
                                    <tbody>
                                    <tr style="height: 13px;">
                                        <td style="width: 25%; height: 13px;">&nbsp;</td>
                                        <td style="width: 25%; text-align: center; height: 13px;"><span
                                                style="text-decoration: underline;"><strong>Batas Harga Awal</strong></span>
                                        </td>
                                        <td style="width: 25%; text-align: center; height: 13px;"><span
                                                style="text-decoration: underline;"><strong>Batas Harga Tengah</strong></span>
                                        </td>
                                        <td style="width: 25%; text-align: center; height: 13px;"><span
                                                style="text-decoration: underline;"><strong>Batas Harga Akhir</strong></span>
                                        </td>
                                    </tr>
                                    <tr style="height: 13.375px;">
                                        <td style="height: 13.375px;"><strong>Dibawah 7.000 points</strong></td>
                                        <td style="text-align: center; height: 13.375px;">+/- 1.000</td>
                                        <td style="text-align: center; height: 13.375px;">+/- 1.500 points</td>
                                        <td style="text-align: center; height: 13.375px;">+/- 2.000 points</td>
                                    </tr>
                                    <tr style="height: 26px;">
                                        <td style="height: 26px;"><strong>7.000 points sampai dibawah 10.000
                                            points</strong></td>
                                        <td style="text-align: center; height: 26px;">N.A.</td>
                                        <td style="text-align: center; height: 26px;">+/- 1.500 points</td>
                                        <td style="text-align: center; height: 26px;">+/- 2.000 points</td>
                                    </tr>
                                    <tr style="height: 13px;">
                                        <td style="height: 13px;"><strong>10.000 points keatas</strong></td>
                                        <td style="text-align: center; height: 13px;">N.A.</td>
                                        <td style="text-align: center; height: 13px;">N.A.</td>
                                        <td style="text-align: center; height: 13px;">+/- 2.000 points</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <p>Setiap kali batas harga awal dan / atau tengah yang tercapai, masa tenang
                                    sepuluh menit akan dilaksanakan selama perdagangan terbatas pada batas harga
                                    yang berlaku. Setelah masa tenang, batas harga yang akan dikeluarkan akan
                                    diperluas dengan batas harga yang berlaku berikutnya (tengah atau akhir).
                                    Tidak akan ada perdagangan dalam setiap kontrak diluar batas harga akhir
                                    untuk sisa hari perdagangan. Bursa akan memulai sinyal dimulainya masa
                                    tenang ketika ada permintaan yang tidak memuaskan atau penawaran pada batas
                                    harga atas yang berlaku atau batas harga yang lebih rendah masing-masing
                                    untuk jangka waktu terus menerus lebih dari sepuluh detik. Bursa menggunakan
                                    kebijakannya untuk memperhitungkan faktor-faktor lain dipasar dalam
                                    menentukan dimulainya masa tenang. Berkaitan dengan sesi T+1, harga
                                    settlement harian diperoleh dalam sesi T yang baru saja berakhir yang akan
                                    menjadi harga acuan untuk menentukan batas harga</p>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Batas Pergerakan Harga untuk Indeks Kospi</strong></td>
                            <td colspan="3">Pemberhentian perdagangan akan diberlakukan apabila terjadi
                                penurunan harga Indeks Kospi lebih dari 8%,15%, dan 20% dari harga penutupan
                                hari sebelumnya, jika kondisi tersebut berlangsung selama 1 menit, perdagangan
                                Indeks Kospi akan diberhentikan. Ketika Indeks Kospi mengalami penurunan lebih
                                dari 8% dari harga penutupan sebelumnya, tahap pertama penghentian akan dimulai.
                                Setelah itu, apabila Indeks Kospi mengalami penurunan kembali lebih dari 15%
                                dari harga penutupan sebelumnya dan terjadi 1% penurunan tambahan dibandingkan
                                dengan harga Indeks pada tahap 1, maka penghentian tahap 2 akan diberlakukan.
                                Apabila tahap 1 dan 2 telah terjadi, perdagangan Indeks Kospi akan diberhentikan
                                selama 20 menit. Penerapan dari setiap tahap adalah terbatas sekali dalam satu
                                hari dan untuk melindungi waktu dalam menentukan harga penutupan pasar,
                                penghentian tersebut tidak diberlakukan selama 40 menit sebelum penutupan pasar.
                                Setelah tahap 2 diberlakukan, apabila Indeks Kospi masih mengalami penurunan
                                lebih dari 20% dari harga penutupan sebelumnya dan terjadi 1% penurunan tambahan
                                dibandingkan dengan harga Indeks pada tahap 2, semua perdagangan Indeks Kospi
                                akan dihentikan. Seperti pada tahap 2 adalah mungkin akan diberlakukan bahkan
                                setelah 40 menit sebelum penutupan pasar
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table border="1">
                        <tbody>
                        <tr style="background-color: #999999; height: 13px;">
                            <td style="height: 13px;" width="25%"><strong>Indeks Rollover Asia</strong></td>
                            <td style="text-align: center; height: 13px;" width="25%"><strong>Hang Seng
                                Indeks</strong></td>
                            <td style="text-align: center; height: 13px;" width="25%"><strong>Nikkei
                                Indeks</strong></td>
                            <td style="text-align: center; height: 13px;" width="25%"><strong>Kospi
                                Indeks</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Besaran Kontrak</strong></td>
                            <td style="text-align: center; height: 13px;">HKD 50 x Indeks Future Rate</td>
                            <td style="text-align: center; height: 13px;">¥ 500 x Indeks Future Rate</td>
                            <td style="text-align: center; height: 13px;">KRW 500,000 x Indeks Future Rate</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Nilai Kurs Tukar Tetap</strong></td>
                            <td style="text-align: center; height: 13px;">HKD 1 = Rp. 1,000-</td>
                            <td style="text-align: center; height: 13px;">¥ 1 = Rp. 100-</td>
                            <td style="text-align: center; height: 13px;">KRW 1 = Rp. 10-</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Value Per Indeks Point</strong></td>
                            <td style="text-align: center; height: 13px;">Rp. 50,000- / USD 5-</td>
                            <td style="text-align: center; height: 13px;">Rp. 50,000- / USD 5-</td>
                            <td style="text-align: center; height: 13px;">Rp. 50,000- / USD 5-</td>
                        </tr>
                        <tr style="height: 13.375px;">
                            <td style="height: 13.375px;"><strong>Minimum tick</strong></td>
                            <td style="text-align: center; height: 13.375px;">1 indeks point</td>
                            <td style="text-align: center; height: 13.375px;">5 indeks point</td>
                            <td style="text-align: center; height: 13.375px;">0.05 indeks point</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Spread minimum Bid / Ask</strong> <strong><em>(Situasi
                                pasar </em><em>normal)</em></strong></td>
                            <td style="text-align: center; height: 26px;" colspan="3">5 pips (Transaksi Online)
                                / 10 pips (Transaksi Telepon)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan per lot</strong> <strong>(Day
                                &amp; Overnight Trade)</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="3">Rp. 10.000.000,- / USD
                                1,000- (Day Trade) <br>Rp. 20.000.000,- / USD 2,000- (Overnight Trade)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan untuk posisi locking per
                                pasang</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="3">Rp. 1.000.000,- / USD
                                100-
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya komisi per lot</strong> <strong>(Open
                                Only)</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3">Rp. 500.000,- / USD 50-
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Waktu perdagangan (WIB) (Senin - Jumat)</strong>
                            </td>
                            <td style="text-align: center; height: 26px;">I. 08:15am – 11:00am <br>II. 12:00pm –
                                03:30pm
                            </td>
                            <td style="text-align: center; height: 26px;">I. 06:30am – 01:25pm <br>II. 01:55pm –
                                03:45am
                            </td>
                            <td style="text-align: center; height: 26px;">I. 07:00am – 01:35pm</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Bulan kontrak</strong></td>
                            <td style="text-align: center; height: 13px;">Setiap bulan</td>
                            <td style="text-align: center; height: 13px;" colspan="2">Maret, Juni, September
                                &amp; Desember
                            </td>
                        </tr>
                        <tr style="height: 65px;">
                            <td style="height: 65px;"><strong>Bulan penyesuaian untuk hari perdagangan gulir
                                (rollover)</strong></td>
                            <td style="text-align: justify; height: 65px;">2 hari kerja terakhir sebelum bulan
                                kontrak lama berakhir. Jika hari tersebut tidak ada hari perdagangan, maka hari
                                sebelumnya akan menjadi hari untuk bulan penyesuaian perdagangan.
                            </td>
                            <td style="text-align: justify; height: 65px;" colspan="2">1 hari kerja sebelum hari
                                Kamis pada minggu ke-2 bulan kontrak. Jika hari tersebut tidak ada hari
                                perdagangan, maka hari sebelumnya akan menjadi hari untuk bulan penyesuaian
                                perdagangan.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Referensi patokan harga gulir (rollover)</strong>
                            </td>
                            <td style="height: 26px;" colspan="3">Referensi patokan harga menggunakan bulan
                                kontrak lama sampai 1 hari kerja sebelum bulan kontrak lama berakhir. <br>Selanjutnya,
                                referensi patokan harga menggunakan bulan kontrak baru pada hari bulan kontrak
                                lama berakhir.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Rumus perhitungan penyesuaian profit &amp; loss
                                gulir (rollover)</strong></td>
                            <td style="height: 26px;" colspan="3"><strong>Posisi Beli:</strong> (Harga penutupan
                                bulan kontrak lama – Harga penutupan bulan kontrak baru) x Besaran kontrak x
                                Lots <br><strong>Posisi Jual:</strong> (Harga penutupan bulan kontrak baru –
                                Harga penutupan bulan kontrak lama) x Besaran kontrak x Lots
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya gulir (rollover fee)</strong></td>
                            <td style="height: 13px; text-align: center;" colspan="3">Tidak ada biaya rollover
                                (Rp. 0-)
                            </td>
                        </tr>
                        <tr style="height: 39px;">
                            <td style="height: 39px;"><strong>Perlindungan kisaran perdagangan untuk Indeks Asia
                                (Open Gap)</strong></td>
                            <td style="height: 39px;" colspan="3">Semua posisi yang menginap (overnight
                                position) untuk Indeks Asia akan dilikuidasi secara otomatis ketika harga
                                pembukaan (Pembukaan harga BID &amp; Pembukaan harga ASK) bergerak 300 points
                                dari harga penutupan sebelumnya (Penutupan harga BID &amp; Penutupan harga ASK).
                                Hanya posisi locking yang tidak terpengaruh.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table border="1">
                        <tbody>
                        <tr>
                            <td style="width: 25%;"><strong>Batas Pergerakan Harga untuk Indeks Nikkei</strong>
                            </td>
                            <td style="width: 75%;">
                                <table style="width: 100%;" border="0">
                                    <tbody>
                                    <tr style="height: 13px;">
                                        <td style="width: 25%; height: 13px;">&nbsp;</td>
                                        <td style="width: 25%; text-align: center; height: 13px;"><span
                                                style="text-decoration: underline;"><strong>Batas Harga Awal</strong></span>
                                        </td>
                                        <td style="width: 25%; text-align: center; height: 13px;"><span
                                                style="text-decoration: underline;"><strong>Batas Harga Tengah</strong></span>
                                        </td>
                                        <td style="width: 25%; text-align: center; height: 13px;"><span
                                                style="text-decoration: underline;"><strong>Batas Harga Akhir</strong></span>
                                        </td>
                                    </tr>
                                    <tr style="height: 13.375px;">
                                        <td style="height: 13.375px;"><strong>Dibawah 7.000 points</strong></td>
                                        <td style="text-align: center; height: 13.375px;">+/- 1.000</td>
                                        <td style="text-align: center; height: 13.375px;">+/- 1.500 points</td>
                                        <td style="text-align: center; height: 13.375px;">+/- 2.000 points</td>
                                    </tr>
                                    <tr style="height: 26px;">
                                        <td style="height: 26px;"><strong>7.000 points sampai dibawah 10.000
                                            points</strong></td>
                                        <td style="text-align: center; height: 26px;">N.A.</td>
                                        <td style="text-align: center; height: 26px;">+/- 1.500 points</td>
                                        <td style="text-align: center; height: 26px;">+/- 2.000 points</td>
                                    </tr>
                                    <tr style="height: 13px;">
                                        <td style="height: 13px;"><strong>10.000 points keatas</strong></td>
                                        <td style="text-align: center; height: 13px;">N.A.</td>
                                        <td style="text-align: center; height: 13px;">N.A.</td>
                                        <td style="text-align: center; height: 13px;">+/- 2.000 points</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <p><u></u>Setiap kali batas harga awal dan / atau tengah yang tercapai, masa
                                    tenang sepuluh menit akan dilaksanakan selama perdagangan terbatas pada
                                    batas harga yang berlaku. Setelah masa tenang, batas harga yang akan
                                    dikeluarkan akan diperluas dengan batas harga yang berlaku berikutnya
                                    (tengah atau akhir). Tidak akan ada perdagangan dalam setiap kontrak diluar
                                    batas harga akhir untuk sisa hari perdagangan. Bursa akan memulai sinyal
                                    dimulainya masa tenang ketika ada permintaan yang tidak memuaskan atau
                                    penawaran pada batas harga atas yang berlaku atau batas harga yang lebih
                                    rendah masing-masing untuk jangka waktu terus menerus lebih dari sepuluh
                                    detik. Bursa menggunakan kebijakannya untuk memperhitungkan faktor-faktor
                                    lain dipasar dalam menentukan dimulainya masa tenang. Berkaitan dengan sesi
                                    T+1, harga settlement harian diperoleh dalam sesi T yang baru saja berakhir
                                    yang akan menjadi harga acuan untuk menentukan batas harga.</p>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Batas Pergerakan Harga untuk Indeks Kospi</strong></td>
                            <td>Pemberhentian perdagangan akan diberlakukan apabila terjadi penurunan harga
                                Indeks Kospi lebih dari 8%, 15%, dan 20% dari harga penutupan hari sebelumnya,
                                jika kondisi tersebut berlangsung selama 1 menit, perdagangan Indeks Kospi akan
                                diberhentikan. Ketika Indeks Kospi mengalami penurunan lebih dari 8% dari harga
                                penutupan sebelumnya, tahap pertama penghentian akan dimulai. Setelah itu,
                                apabila Indeks Kospi mengalami penurunan kembali lebih dari 15% dari harga
                                penutupan sebelumnya dan terjadi 1% penurunan tambahan dibandingkan dengan harga
                                Indeks pada tahap 1, maka penghentian tahap 2 akan diberlakukan. Apabila tahap 1
                                dan 2 telah terjadi, perdagangan Indeks Kospi akan diberhentikan selama 20
                                menit. Penerapan dari setiap tahap adalah terbatas sekali dalam satu hari dan
                                untuk melindungi waktu dalam menentukan harga penutupan pasar, penghentian
                                tersebut tidak diberlakukan selama 40 menit sebelum penutupan pasar. Setelah
                                tahap 2 diberlakukan, apabila Indeks Kospi masih mengalami penurunan lebih dari
                                20% dari harga penutupan sebelumnya dan terjadi 1% penurunan tambahan
                                dibandingkan dengan harga Indeks pada tahap 2, semua perdagangan Indeks Kospi
                                akan dihentikan. Seperti pada tahap 2 adalah mungkin akan diberlakukan bahkan
                                setelah 40 menit sebelum penutupan pasar.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table border="1">
                        <tbody>
                        <tr style="background-color: #999999; height: 13px;">
                            <td style="width: 25%; height: 13px;"><strong>Indeks Rollover Amerika</strong></td>
                            <td style="width: 25%; text-align: center; height: 13px;"><strong>Dow Jones
                                Indeks</strong></td>
                            <td style="width: 25%; text-align: center; height: 13px;"><strong>S&amp;P 500
                                Indeks</strong></td>
                            <td style="width: 25%; text-align: center; height: 13px;"><strong>Nasdaq
                                Indeks</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Besaran kontrak</strong></td>
                            <td style="text-align: center; height: 13px;">USD 5 x Indeks Future Rate</td>
                            <td style="text-align: center; height: 13px;">USD 50 x Indeks Future Rate</td>
                            <td style="text-align: center; height: 13px;">USD 20 x Indeks Future Rate</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Nilai Kurs Tukar Tetap</strong></td>
                            <td style="text-align: center; height: 13px;">USD 1 = Rp. 10,000</td>
                            <td style="text-align: center; height: 13px;">USD 1 = Rp. 10,000</td>
                            <td style="text-align: center; height: 13px;">USD 1 = Rp. 10,000</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Value Per Indeks Point</strong></td>
                            <td style="text-align: center; height: 13px;">Rp. 50,000- / USD 5-</td>
                            <td style="text-align: center; height: 13px;">Rp. 500,000- / USD 50-</td>
                            <td style="text-align: center; height: 13px;">Rp. 200,000- / USD 20-</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Minimum tick</strong></td>
                            <td style="text-align: center; height: 13px;">1 indeks point</td>
                            <td style="text-align: center; height: 13px;">0.25 indeks point</td>
                            <td style="text-align: center; height: 13px;">0.25 indeks point</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Spread minimum Bid / Ask</strong> <strong>(<em>Situasi
                                pasar </em><em>n</em><em>ormal</em>)</strong></td>
                            <td style="text-align: center; height: 26px;">5 indeks points (Transaksi Online)
                                <br>10 indeks points (Transaksi Telepon)
                            </td>
                            <td style="text-align: center; height: 26px;">0.50 indeks points (Transaksi Online)
                                <br>1 indeks points (Transaksi Telepon)
                            </td>
                            <td style="text-align: center; height: 26px;">1 indeks points (Transaksi Online
                                &amp; Telepon)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan per lot</strong> <strong>(Day
                                &amp; overnight trade)</strong></td>
                            <td style="text-align: center; height: 26px;">Rp. 20.000.000,- / USD 2,000-</td>
                            <td style="text-align: center; height: 26px;">Rp. 25.000.000,- / USD 2,500-</td>
                            <td style="text-align: center; height: 26px;">Rp. 20.000.000,- / USD 2,000-</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan untuk posisi locking per
                                pasang</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="3">Rp. 2.000.000,- / USD
                                200-
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya komisi per lot</strong> <strong>(Open
                                Only)</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="3">Rp. 500.000,- / USD 50-
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Waktu perdagangan (WIB) (Senin – Jumat)</strong>
                            </td>
                            <td style="text-align: center; height: 26px;" colspan="3">06:00am – 04:15am (Musim
                                Dingin) <br>05:00am – 03:15am (Musim Panas)
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table border="1">
                        <tbody>
                        <tr style="height: 13px;">
                            <td style="width: 25%; height: 13px;"><strong>Bulan kontrak</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="2">Maret, Juni, September
                                &amp; Desember
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Bulan penyesuaian untuk hari perdagangan gulir
                                (rollover)</strong></td>
                            <td style="height: 26px;" colspan="2">2 hari kerja sebelum Jumat minggu ke-3 bulan
                                kontrak lama. Jika pada hari tersebut tidak ada hari perdagangan maka hari
                                sebelumnya akan menjadi hari untuk bulan penyesuaian perdagangan.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Referensi patokan harga gulir (rollover)</strong>
                            </td>
                            <td style="height: 26px;" colspan="2">Referensi patokan harga menggunakan bulan
                                kontrak lama sampai 2 hari kerja sebelum Jumat minggu ke- 3 bulan kontrak lama
                                berakhir. Selanjutnya, referensi patokan harga menggunakan bulan kontrak baru
                                pada hari bulan kontrak lama berakhir.
                            </td>
                        </tr>
                        <tr style="height: 39px;">
                            <td style="height: 39px;"><strong>Rumus perhitungan penyesuaian profit &amp; loss
                                gulir (rollover)</strong></td>
                            <td style="height: 39px;" colspan="2"><strong>Posisi Beli:</strong> <br>(Harga
                                penutupan bulan kontrak lama – Harga penutupan bulan kontrak baru) x Besaran
                                kontrak x Lots <br><strong>Posisi Jual:</strong> <br>(Harga penutupan bulan
                                kontrak baru – Harga penutupan bulan kontrak lama) x Besaran kontrak x Lots
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya gulir (rollover fee)</strong></td>
                            <td style="height: 13px;" colspan="2">Tidak ada biaya rollover (Rp. 0-)</td>
                        </tr>
                        <tr style="height: 52px;">
                            <td style="height: 52px;"><strong>Batas pergerakan harga untuk US Indices gulir
                                (rollover)</strong></td>
                            <td style="height: 52px;" colspan="2">7% (Level 1), 13% (Level 2), and 20% (Level 3)
                                batas harga yang efektif adalah dari 8:30pm – 3:00am <strong>(WIB) </strong>Senin
                                sampai Sabtu. 5% batas atas dan bawah yang efektif adalah dari 5:00am - 8:30pm
                                <strong>(WIB) </strong>Senin sampai Jumat; dan 3:00am - 3:15am
                                <strong>(WIB) </strong>Selasa sampai Sabtu. Antara 3:00am - 3:15am
                                <strong>(WIB) </strong>batasan harga 5% tersebut tidak diberlakukan untuk batas
                                akhir harian 20%. <strong>**Semua waktu perdagangan berdasarkan waktu musim
                                    panas.</strong></td>
                        </tr>
                        <tr style="background-color: #999999; height: 13px;">
                            <td style="height: 13px;"><strong>Indeks Rollover Eropa</strong></td>
                            <td style="text-align: center; height: 13px;"><strong>FTSE Indeks</strong></td>
                            <td style="text-align: center; height: 13px;"><strong>DAX Indeks</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Besaran kontrak</strong></td>
                            <td style="text-align: center; height: 13px;">USD 15 x Indeks Future Rate</td>
                            <td style="text-align: center; height: 13px;">USD 30 x Indeks Future Rate</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Nilai Kurs Tukar Tetap</strong></td>
                            <td style="text-align: center; height: 13px;">USD 1 = Rp. 10,000-</td>
                            <td style="text-align: center; height: 13px;">USD 1 = Rp. 10,000-</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Value Per Indeks Point</strong></td>
                            <td style="text-align: center; height: 13px;">Rp. 150,000- / USD 15-</td>
                            <td style="text-align: center; height: 13px;">Rp. 300,000- / USD 30-</td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Minimum tick</strong></td>
                            <td style="text-align: center; height: 13px;">0.50 indeks point</td>
                            <td style="text-align: center; height: 13px;">0.50 indeks point</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Spread minimum Bid / Ask</strong> <strong>(<em>Situasi
                                pasar </em><em>n</em><em>ormal</em>)</strong></td>
                            <td style="text-align: center; height: 26px;">2 indeks points (Transaksi Online
                                &amp; Telepon)
                            </td>
                            <td style="text-align: center; height: 26px;">2 indeks points (Transaksi Online
                                &amp; Telepon)
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan per lot</strong> <strong>(Day
                                &amp; Overnight trade)</strong></td>
                            <td style="text-align: center; height: 26px;">Rp. 20.000.000,- / USD 2,000-</td>
                            <td style="text-align: center; height: 26px;">Rp. 50.000.000,- / USD 5,000</td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Margin dibutuhkan untuk posisi locking per
                                pasang</strong></td>
                            <td style="text-align: center; height: 26px;" colspan="2">Rp. 2.000.000,- / USD
                                200-
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya komisi per lot</strong> <strong>(Open
                                Only)</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="2">Rp. 500.000,- / USD 50-
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Waktu perdagangan (WIB) (Senin - Jumat)</strong>
                            </td>
                            <td style="text-align: center; height: 26px;"><strong>14:01 – 04:00 (Musim
                                Dingin)</strong> <br><strong>13:01 – 03:00 (Musim Panas)</strong></td>
                            <td style="text-align: center; height: 26px;"><strong>14:00 – 04:00 (Musim
                                Dingin)</strong> <br><strong>13:00 – 03:00 (Musim Panas)</strong></td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Bulan kontrak</strong></td>
                            <td style="text-align: center; height: 13px;" colspan="2">Maret, Juni, September
                                &amp; Desember
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Bulan penyesuaian untuk hari perdagangan gulir
                                (rollover)</strong></td>
                            <td style="height: 26px;" colspan="2">2 hari kerja sebelum Jumat minggu ke-3 bulan
                                kontrak lama. Jika pada hari tersebut tidak ada hari perdagangan maka hari
                                sebelumnya akan menjadi hari untuk bulan penyesuaian perdagangan.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Referensi patokan harga gulir (rollover)</strong>
                            </td>
                            <td style="height: 26px;" colspan="2">Referensi patokan harga menggunakan bulan
                                kontrak lama sampai 2 hari kerja sebelum Jumat minggu ke-3 bulan kontrak lama
                                berakhir. Selanjutnya, referensi patokan harga menggunakan bulan kontrak baru
                                pada hari bulan kontrak lama berakhir.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Rumus perhitungan penyesuaian profit &amp; loss
                                gulir (rollover)</strong></td>
                            <td style="height: 26px;" colspan="2"><strong>Posisi Beli:</strong> <br>(Harga
                                penutupan bulan kontrak lama – Harga penutupan bulan kontrak baru) x Besaran
                                kontrak x Lots <br><strong>Posisi Jual:</strong> <br>(Harga penutupan bulan
                                kontrak baru – Harga penutupan bulan kontrak lama) x Besaran kontrak x Lots
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td style="height: 13px;"><strong>Biaya gulir (rollover fee)</strong></td>
                            <td style="height: 13px; text-align: center;" colspan="2">Tidak ada biaya rollover
                                (Rp. 0-)
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <table border="1">
                        <tbody>
                        <tr style="height: 13px; background-color: #999999;">
                            <td style="height: 13px; width: 25%;"><strong>Deposit Awal</strong></td>
                            <td style="height: 13px; width: 75%; text-align: center;"><strong>Rp 100.000.000,- /
                                USD 10,000-</strong></td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Order perdagangan</strong></td>
                            <td style="height: 26px;">Semua order diterima dan dilaksanakan dengan pengertian
                                bahwa nasabah mampu menyelesaikan transaksi dengan memegang dan / atau
                                menyerahkan deposit margin.
                            </td>
                        </tr>
                        <tr style="height: 39px;">
                            <td style="height: 39px;"><strong>Kelebihan Transaksi</strong>
                                <strong>(Overtrading)</strong></td>
                            <td style="height: 39px;">Ketika order perdagangan melebihi batas limit dari open
                                posisi yang diperbolehkan melebihi effective margin, maka order perdagangan
                                tersebut akan dilikuidasi dengan spread (bid &amp; ask) tetapi tidak dikenakan
                                biaya komisi.
                            </td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>DQ quota (Maksimum)</strong></td>
                            <td style="height: 26px;">Maksimal 50 lots (Baru atau likuidasi) yang diperbolehkan
                                untuk setiap sekali DQ.
                            </td>
                        </tr>
                        <tr style="height: 39px;">
                            <td style="height: 39px;"><strong>Order eksekusi</strong></td>
                            <td style="height: 39px;">Semua order harus ditempatkan melalui sistem perdagangan
                                TGF atau melalui telepon ke dealing. Semua order yang diterima sesuai dengan
                                kebijakan yang ada di TGF. Order market akan dieksekusi di harga saat nasabah
                                mengajukan dan mengkonfirmasi order tersebut. Selama masa volatilitas, beberapa
                                order mungkin bisa ditolak oleh dealing dikarenakan perubahan harga yang sangat
                                cepat.
                            </td>
                        </tr>
                        <tr style="height: 39px;">
                            <td style="height: 39px;"><strong>Perubahan pada market order</strong></td>
                            <td style="height: 39px;">Setelah order dikonfirmasi oleh sistem perdagangan TGF
                                atau melalui telepon, <u>tidak diperbolehkan ada</u><u>perubahan</u> detail
                                apapun pada market order termasuk nomor akun, posisi (beli atau jual, baru atau
                                likuidasi), produk trading, harga eksekusi, jumlah lot, bulan kontrak (trading
                                month).
                            </td>
                        </tr>
                        <tr style="height: 91px;">
                            <td style="height: 91px;"><strong>Pasang Limit order, Stop loss order &amp; O.C.O.
                                order</strong></td>
                            <td style="height: 91px;">Maksimal 50 lots (baru atau likuidasi) yang diterima untuk
                                setiap limit order &amp; stop loss order. Orders dapat dipasang ketika harga
                                market sekurang-kurangnya (30 pips untuk HSI, Nikkei, Kospi &amp; Dow Jones /
                                7.5 points untuk S&amp;P &amp; Nasdaq / 15 points untuk FTSE &amp; DAX) dari
                                harga yang diinginkan dan hanya setelah mendapat konfirmasi dari dealer harga
                                dapat diterima, contoh untuk order beli, harga yang diinginkan harus (30 pips
                                untuk HSI, Nikkei, Kospi &amp; Dow Jones / 7.5 points untuk S&amp;P &amp; Nasdaq
                                / 15 points untuk FTSE &amp; DAX) dari harga ask di layar monitor; dan untuk
                                order jual, harga yang diinginkan harus be (30 pips untuk HSI, Nikkei, Kospi
                                &amp; Dow Jones / 7.5 points untuk S&amp;P &amp; Nasdaq / 15 points untuk FTSE
                                &amp; DAX) dari harga bid di layar monitor. Akan tetapi dealer dapat setiap
                                waktu dengan kebijakannya sendiri dapat menerima atau menolak order tersebut..
                                <br><strong><u>**</u><u>S</u><u>em</u><u>u</u><u>a produk tidak diperbolehkan
                                    untuk memasang stop loss order untuk posisi baru kecuali</u><u>untuk
                                    likuidasi atau posisi locking.</u></strong></td>
                        </tr>
                        <tr style="height: 26px;">
                            <td style="height: 26px;"><strong>Perubahan limit order</strong></td>
                            <td style="height: 26px;">Limit order dapat dirubah sebelum menjadi order ketika
                                market pasar setidaknya (30 pips untuk HSI, Nikkei, Kospi &amp; Dow Jones / 7.5
                                points untuk S&amp;P &amp; Nasdaq / 15 points untuk FTSE &amp; DAX) jauhnya dari
                                harga yang diinginkan.
                            </td>
                        </tr>
                        <tr style="height: 52px;">
                            <td style="height: 52px;"><strong>Pembatalan limit order</strong></td>
                            <td style="height: 52px;">
                                <ol>
                                    <li>Limit order dapat dibatalkan ketika harga limit belum di eksekusi dan
                                        hanya jika sistem perdagangan online TGF mengkonfirmasi pembatalan
                                        tersebut.
                                    </li>
                                    <li>Good Till Market Close (G.T.M.C): <br>a. Indeks Amerika &amp; Indeks
                                        Eropa: Order akan berlaku pada hari tersebut dan penutupan pasar harian
                                        (good till daily). <br>b. Indeks Asia (HSI, Nikkei &amp; Kospi): Order
                                        akan berlaku selama sesi perdagangan saja. Oleh karena itu, semua order
                                        G.T.M.C. akan dibatalkan setelah penutupan setiap sesi perdagangan.
                                    </li>
                                    <li>Limit Settle Order akan otomatis dibatalkan jika harga open posisi telah
                                        dilikuidasi atau salah.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr style="height: 52px;">
                            <td style="height: 52px;"><strong>Eksekusi limit order</strong></td>
                            <td style="height: 52px;">
                                <ol>
                                    <li>Harga yang diinginkan telah diquote oleh basis sistem online TGF pada
                                        BID / ASK.
                                    </li>
                                    <li>Untuk <u>order bel</u>i akan di eksekusi ketika harga ask pada layar
                                        menyentuh harga yang diinginkan; dan <u>order jua</u>l akan dieksekusi
                                        ketika harga bid pada layar menyentuh harga yang diinginkan.
                                    </li>
                                    <li>Order limit akan diaktifkan oleh harga yang ditunjukkan oleh nasabah.
                                        Namun selama sesi volatil yang ekstrems, eksekusi tersebut mungkin tidak
                                        dapat dilakukan dan slippage bisa terjadi pada harga eksekusi oleh
                                        sistem perdagangan online TGF ini.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr style="height: 39px;">
                            <td style="height: 39px;"><strong>Market on close</strong> <strong>(MOC)
                                order</strong></td>
                            <td style="height: 39px;">Order MOC harus dipasang hanya melalui telepon setidaknya
                                15 menit sebelum penutupan pasar. Order beli (buy) dengan MOC berdasarkan pada
                                penutupan harga ASK. Order jual (sell) dengan MOC berdasarkan pada penutupan
                                harga BID. Order MOC untuk likuidasi akan otomatis dibatalkan jika harga posisi
                                terbuka telah dilikuidasi atau salah.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table border="1">
                        <tbody>
                        <tr>
                            <td style="width: 25%;"><strong>Margin call level</strong></td>
                            <td style="width: 75%;">Ketika efektif margin dibawah 70% dari margin yang
                                diperlukan, nasabah akan menerima pemberitahuan margin call melalui e-mail atau
                                melalui telepon. Sebuah akun dapat dianggap kekurangan margin setiap kali
                                efektif margin kurang dari 70% dari margin yang diperlukan selama penutupan
                                pasar. TGF akan menutup posisi nasabah dengan memakai harga penutupan (BID/ASK)
                                dengan metode last-in-first out (LIFO) sampai efektif margin mencukupi diatas
                                ambang batas 70%. Ini dilakukan atas dasar upaya terbaik dan TGF berhak untuk
                                menutup salah satu atau semua posisi nasabah.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Cut loss level</strong></td>
                            <td>Jika efektif margin di akun pada setiap saat turun atau dibawah 20% dari margin
                                yang diperlukan, TGF akan menutup semua posisi nasabah dengan menggunakan harga
                                cut loss (BID/ASK). Tergantung pada volatilitas pasar, penutupan posisi nasabah
                                mungkin akan terpengaruh dibawah ambang batas 20% dan efektif margin pada akun
                                bisa menjadi minus. Nasabah harus bertanggung jawab terhadap jumlah efektif
                                margin yang mengalami defisit.
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Lain - lain (Miscellaneous)</strong></td>
                            <td>
                                <ol>
                                    <li>TGF akan memberikan password pribadi kepada nasabah dan identifikasi
                                        user (bernama "Kode Akses"). Kode akses akan memungkinkan nasabah untuk
                                        mengakses akun dan memasukan order kedalam akun melalui sistem online
                                        trading TGF ini. Nasabah harus menjaga kerahasiaan kode akses setiap
                                        saat. Nasabah menerima tanggung jawab penuh atas penggunaan dan
                                        perlindungan yang meliputi kode akses, namun tak terbatas pada semua
                                        order yang masuk ke sistem perdagangan online TGF yang menggunakan kode
                                        akses dan perubahan dalam informasi akun nasabah yang masuk menggunakan
                                        kode akses.
                                    </li>
                                    <li>Nasabah harus bertanggung jawab untuk selalu tetap meng-update status
                                        bapak / ibu terhadap akun transaksi (trading account) dan laporan
                                        hariannya (daily statements).
                                    </li>
                                    <li>Semua instruksi yang terkait dengan akun nasabah dan prosedur
                                        perdagangan atau model transaksi selain petunjuk dalam perjanjian
                                        nasabah (Client Agreement) harus diserahkan kepada perusahaan secara
                                        tertulis saja. Tidak ada instruksi lisan yang diterima atau diakui.
                                    </li>
                                </ol>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Keluhan (Complaints)</strong></td>
                            <td>Jika ada perbedaan / perselisihan, dealer hanya akan menerima keluhan tidak
                                lebih dari 30 menit setelah perbedaan / perselisihan tersebut diungkapkan.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <p>
                    Dengan mengisi kolom "YA" di bawah ini, saya menyatakan bahwa saya telah membaca
                    tentang <strong>PERATURAN PERDAGANGAN <i>(TRADING RULES)</i></strong>,
                    mengerti dan menerima ketentuan dalam bertransaksi.
                </p>
            </div>
        </div>
        <div class="tab-pane" id="RealAccountWizardTab8">
            <div class="row">
                <div class="col-md-8 col-sm-6">Formulir Nomor 107.BPK.07</div>
                <div class="col-md-4 col-sm-6">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Lampiran</td>
                            <td>:</td>
                            <td>Peraturan Kepala Badan Pengawas</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>Perdagangan Berjangka Komoditi</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>Nomor: 107/BAPPEBTI/PER/11/2013</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 col-sm-12">
                    <p class="text-center">
                        <strong>PERNYATAAN BERTANGGUNG JAWAB ATAS</strong>
                    </p>
                    <p class="text-center">
                        <strong>
                            KODE AKSES TRANSAKSI NASABAH
                            <i>(Personal Access Password)</i>
                        </strong>
                    </p>
                    <p>
                        Yang mengisi formulir di bawah ini:
                    </p>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">
                            Nama Lengkap
                        </label>
                        <div class="col-md-10 col-sm-12">:
                            <p class="form-control-static">
                                josen
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">
                            Tempat, Tgl Lahir
                        </label>
                        <div class="col-md-10 col-sm-12">:
                            <p class="form-control-static">
                                china beijing,
                                06-06-1984
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">
                            Alamat Rumah
                        </label>
                        <div class="col-md-10 col-sm-12">:
                            <p class="form-control-static">
                                china beijing
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">
                            Kode Pos
                        </label>
                        <div class="col-md-10 col-sm-12">:
                            <p class="form-control-static">
                                10010
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12 control-label">
                            No. KTP / ID
                        </label>
                        <div class="col-md-10 col-sm-12">:
                            <p class="form-control-static">
                                01055154898465465
                            </p>
                        </div>
                    </div>
                    <div class="step-2-formulir-items">
                        <label class="col-md-2 col-sm-12">
                            No. Acc.
                        </label>
                        <div class="col-md-10 col-sm-12">:
                            <p class="form-control-static">
                                Menunggu
                            </p>
                        </div>
                    </div>
                    <p>
                        Dengan mengisi kolom "YA" di bawah ini, saya menyatakan bahwa saya
                        bertanggungjawab
                        sepenuhnya terhadap kode akses transaksi Nasabah <i>(Personal Access
                        Password)</i>
                        dan tidak menyerahkan kode akses transaksi Nasabah <i>(Personal
                        Access Password)</i> ke pihak lain,
                        terutama kepada pegawai Pialang Berjangka atau pihak yang memiliki
                        kepentingan dengan
                        Pialang Berjangka.
                    </p>
                    <div class="alert alert-danger text-center">
                        <strong>PERHATIAN !!!</strong>
                        <br>
                        Pialang Berjangka, Wakil Pialang Berjangka, pegawai pialang
                        berjangka, atau pihak yang
                        memiliki kepentingan dengan Pialang Berjangka dilarang menerima kode
                        akses transaksi
                        Nasabah <i>(Personal Access Password)</i>.
                    </div>
                    <p>
                        Demikianlah surat pernyataan ini dibuat dengan sebenarnya dalam
                        keadaan sadar,
                        sehat jasmani dan rohani serta tanpa paksaan apapun dari pihak
                        manapun.
                    </p>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="RealAccountWizardTab9">
            <div style="text-align: center; clear: both; margin: 20px 0 20px 0; font: bold 20px arial">
                Surat Pernyataan
            </div>
            <table style="width: 100%">
                <tbody>
                <tr>
                    <td width="200">Nama</td>
                    <td width="20" style="text-align: center;">:</td>
                    <td>josen</td>
                </tr>
                <tr>
                    <td>Nomor Account</td>
                    <td style="text-align: center;">:</td>
                    <td><em>« Menyusul »</em></td>
                </tr>
                <tr valign="top">
                    <td>Alamat</td>
                    <td style="text-align: center;">:</td>
                    <td>china beijing</td>
                </tr>
                <tr>
                    <td>Nomor Telepon</td>
                    <td style="text-align: center;">:</td>
                    <td>15015146486</td>
                </tr>
                <tr>
                    <td>No. KTP / ID</td>
                    <td style="text-align: center;">:</td>
                    <td>01055154898465465</td>
                </tr>
                <tr>
                    <td>Hari, Tanggal dan Jam</td>
                    <td style="text-align: center;">:</td>
                    <td>10-05-2018 10:27:19</td>
                </tr>
                </tbody>
            </table>
            <p>
                Dengan ini memberikan pernyataan dengan sebenar-benarnya dan sejujurnya dalam
                keadaan
                sadar, sehat jasmani dan rohani serta tanpa paksaan apapun dari pihak
                manapun sebagai
                berikut, bahwa saya sudah :
            </p>
            <ol id="ol-pernyataan">
                <li>
                    Mengetahui profile perusahaan Real Time Futures.

                </li>
                <li>
                    Membaca dengan seksama dan mengerti :
                    <ol type="a">
                        <li style="margin-bottom: 0px !important;">
                            Isi Dokumen Pemberitahuan Adanya Risiko Yang Harus Disampaikan Oleh Pialang Berjangka (DPAR) ;
                        </li>
                        <li style="margin-bottom: 0px !important;">
                            isi Perjanjian Pemberian Amanat ; dan
                        </li>
                        <li style="margin-bottom: 0px !important;">
                            istilah-istilah dalam perdagangan berjangka.
                        </li>
                    </ol>
                </li>
                <li>
                    Memahami dan mengerti :
                    <ol type="a">
                        <li style="margin-bottom: 0px !important;">
                            isi Dokumen Pemberitahuan Adanya Risiko Yang Harus Disampaikan Oleh Pialang Berjangka (DPAR) ;
                        </li>
                        <li style="margin-bottom: 0px !important;">
                            isi Perjanjian Pemberian Amanat ; dan
                        </li>
                        <li style="margin-bottom: 0px !important;">
                            istilah-istilah dalam perdagangan berjangka.
                        </li>
                    </ol>
                </li>
                <li>
                    Mengisi Aplikasi Pembukaan Rekening Transaksi dan semua informasi serta
                    dokumen pendukung lainnya adalah benar dan tepat sesuai dengan aslinya
                    dan saya akan bertanggungjawab penuh apabila dikemudian hari terjadi
                    sesuatu hal yang sehubungan dengan ketidak benaran data yang diberikan.
                </li>
                <li>
                    Memahami, mengerti dan mengetahui apabila ada ketidaklengkapan pada
                    pengisian Aplikasi Pembukaan Rekening adalah atas kehendak saya sendiri
                    dan saya akan bertanggungjawab penuh apabila dikemudian hari terjadi
                    sesuatu hal yang sehubungan dengan ketidaklengkapan pada pengisian
                    aplikasi tersebut
                </li>
                <li>
                    Memahami dan telah mendapat penjelasan mengenai mekanisme transaksi
                    perdagangan berjangka yang akan saya lakukan sendiri.
                </li>
                <li>
                    Memahami dan mengerti tentang tata cara bertransaksi perdagangan
                    berjangka dan juga telah melakukan simulasi transaksi perdagangan
                    berjangka pada Real Time Futures.
                </li>
                <li>
                    Mengetahui, memahami, mengerti, menerima dan menyetujui
                    ketentuan-ketentuan yang ada pada Trading Rules.
                </li>
                <li>
                    Memahami dan mengerti bahwa dalam bertransaksi perdagangan Berjangka
                    disamping mempunyai peluang keuntungan yang besar tetapi juga mempunyai
                    resiko kerugian sebagaimana yang disebutkan di dalam Dokumen
                    Pemberitahuan Adanya Resiko.
                </li>
                <li>
                    Memahami dan mengerti bahwa untuk melakukan transaksi di Perdagangan
                    Berjangka, saya harus menempatkan sejumlah dana/margin dan berkewajiban
                    memelihara kecukupan margin tersebut dalam melakukan transaksi, sehingga
                    sewaktu-waktu bisa saja saya berkewajiban untuk menambah sejumlah
                    dana/margin untuk memelihara posisi terbuka saya.
                </li>
                <li>
                    Memahami, mengerti dan mengetahui kegunaan / fungsi dari sistem Cabinet
                    (Investor Management System) selain untuk melakukan registrasi online,
                    juga berfungsi untuk melakukan segala sesuatu yang berhubungan dengan
                    setoran dana maupun penarikan dana
                </li>
                <li>
                    Mengetahui dan memahami bahwa password pada platform trading bersifat
                    rahasia dan hanya diberikan kepada saya sebagai nasabah.
                </li>
                <li>
                    Mengetahui, memahami dan menyetujui bahwa transaksi dilaksanakan melalui
                    sistem online/elektronik sehingga apabila password tersebut
                    jatuh/diberikan kepada pihak lain sekalipun pegawai Real Time Futures, maka hal tersebut menjadi tanggujawab saya sepenuhnya sebagai
                    nasabah.
                </li>
                <li>
                    Mengetahui, mengerti dan memahami bahwa Real Time Futures tidak
                    pernah mengeluarkan, menawarkan, menjanjikan, memberikan harapan,
                    mengiming-imingi atau melakukan tindakan-tindakan yang pada intinya
                    menjanjikan keuntungan tetap (fixed income) atau bagi hasil (profit
                    sharing) atau janji pasti untung (profit guarantee) kepada siapapun baik
                    kepada saya sebagai calon nasabah atau sebagai nasabah maupun
                    pihak-pihak lain untuk melakukan investasi berjangka pada Real Time Futures.
                </li>
                <li>
                    Mengetahui, mengerti dan memahami apabila dikemudian hari saya melakukan
                    tindakan-tindakan sebagaimana yang disebutkan pada poin 13 dan 14, maka
                    hal tersebut sepenuhnya menjadi tanggungjawab saya sebagai nasabah dan
                    tidak melibatkan Real Time Futures dalam permasalahan dimaksud.
                </li>
                <li>
                    Mengetahui, memahami dan mengerti bahwa transaksi yang akan saya lakukan
                    berada dalam mekanisme Sistem Perdagangan Alternatif (SPA) untuk produk
                    Forex, Stodex dan Loco London Gold, dimana Real Time Futures sebagai
                    Pialang (peserta SPA) dan PT PROLINDO BUANA SEMESTA sebagai Pedagang
                    (penyelenggara SPA).<br> Real Time Futures hanya sebagai Pialang yang
                    menyediakan fasilitas dan informasi yang mendukung nasabah bertransaksi
                    dan keputusan sepenuhnya ada pada saya sebagai nasabah.
                </li>
                <li>
                    Membaca, memahami dan mengerti semua pernyataan-pernyataan tersebut
                    diatas poin (1-16) secara jujur dan sebenar-benarnya dalam keadaan
                    sadar, sehat jasmani dan rohani serta tanpa paksaan apapun dari pihak
                    manapun.
                </li>
            </ol>

            <p style="border-top:1px solid #ccc;padding-top:5px;text-align:center">
                <label for="RealAccountWaiverClientAccept"
                       style="position: relative;
                       top: -3px;
                       font-weight: bold;
                       cursor: pointer;"
                >
                    <input type="hidden"
                           name="data[RealAccountWaiverClient][accept]"
                           id="RealAccountWaiverClientAccept_"
                           value="0"
                    >
                    {% if userDatas.state === 1 %}
                    <input type="checkbox"
                           name="data[RealAccountWaiverClient][accept]"
                           class="form-control" value="1" id="RealAccountWaiverClientAccept">
                    Dengan ini saya menyatakan telah membaca, mengerti, memahami dan
                    menyetujui <b>seluruh</b> pernyataan di atas dan segala hal yang timbul
                    akan menjadi tanggungjawab saya sepenuhnya.
                </label>
                {% else %}
                <input type="checkbox"
                       name="data[RealAccountWaiverClient][accept]"
                       class="form-control" value="1"
                       checked
                       disabled
                       id="RealAccountWaiverClientAccept">
                Dengan ini saya menyatakan telah membaca, mengerti, memahami dan
                menyetujui <b>seluruh</b> pernyataan di atas dan segala hal yang timbul
                akan menjadi tanggungjawab saya sepenuhnya.
                </label>

                {% endif %}
                <span class="warninginfo opne-acc-submit-tips" style="width: 100%; ">This field is required.</span>
                <br>
            </p>

        </div>
    </div>
    <!-- 步骤验证 -->
    <div class="step-next-verify">
        <div  style="margin-top: 30px; display: table; width: 100%">
            <div class="col-md-4 col-sm-12">Pernyataan menerima</div>
            <div class="col-md-8 col-sm-12">
                <label class="radio-inline">
                    <input type="radio" name="RealAccountSimulationStatementAccept" value="1" class="valid-true">
                    Ya
                </label>
                <label class="radio-inline" disabled="disabled">
                    <input type="radio" name="RealAccountSimulationStatementAccept" disabled  value="0" class="valid">
                    Tidak
                </label>
            </div>
        </div>
        <div style="margin-top: 30px; display: table; width: 100%">
            <div class="col-md-4 col-sm-12">Menyatakan pada Tanggal</div>
            <div class="col-md-8 col-sm-12"> {{ userDatas.gmt_modified }}</div>
        </div>
    </div>
    <div class="btns" id="step-fun">
        <span class="warninginfo step-next-tips" style="width: 100%; ">This field is required.</span>
        <button id="prevBtn">Previous</button>
        <button id="nextBtn"  class="submit" type="submit">Next</button>
        {% if userDatas.state === 1 %}

        <button id="submitInfo">submitInfo</button>
        {% else %}
        <button id="submitInfo" onclick=window.open('/member/real_accounts/list')>Back</button>
        {% endif %}
    </div>
</div>
</div>
{% endblock %}


{% block js_assets %}

<script type="text/javascript">
    $(document).ready(function () {
        stepBoxDisplay();
        // getAccountInfo(userFormId);
    });
    var $step = $("#step");
    var accountsState = $(".accounts-state").html();
    var stepBox = $('.tab-pane');
    var stepVerify = $('.valid-true');
    var userFormId = getQueryString("no");
    var confirmationVerify = $('#RealAccountWizardTab5').find('.confirmation-verify').find('input');
    var confirmationVerifySix = $('#RealAccountWizardTab6').find('.confirmation-verify').find('input');

    //页面初始化步骤条
    $step.step({
        index: 0,
        time: 500,
        title: ["step 1", "step 2.1", "step 2.2", "step 3", "step 4", "step 5", "step 6", "step 7", "step 8"],
    });


    //页面跳转上一步
    $("#prevBtn").on("click", function () {
        $step.prevStep();
        stepBoxDisplay();
        window.scrollTo(0, 0);
    });

    //页面初始化step5/6所有checked为不可选择
    $(confirmationVerify).each(function() {
        $(this).attr('disabled', 'false');
    });
    $(confirmationVerifySix).each(function() {
        $(this).attr('disabled', 'false');
    });

    if( accountsState == 1 ){
        //页面跳转下一步
        $("#nextBtn").on("click", function () {
            if($step.getIndex() == 4){
                if( typeof confirmationItemsVerify() == "number" ){
                    window.scrollTo(0, confirmationItemsVerify() - 260);
                    return  false;
                }
            }
            if($step.getIndex() == 5){
                if( typeof confirmationItemsVerifySix() == "number" ){
                    window.scrollTo(0, confirmationItemsVerifySix() - 260);
                    return  false;
                }
            }
            if ($(stepVerify).is(':checked')) {
                $('.step-next-tips').hide();
                if($step.getIndex() == 2){
                    if($('#RealAccountTradeExperienceCompanyName').val() == ""){
                        $('.five-step-next-tips').show()
                        return  false;
                    }
                }
                $step.nextStep();
                $(stepVerify).removeAttr("checked");
                stepBoxDisplay();
                window.scrollTo(0, 0);
            } else {
                $('.step-next-tips').show()
            }
        });


        //页面初始化step5/6所有checked为第一个可选择
        $(confirmationVerify).eq(0).removeAttr('disabled');
        $(confirmationVerifySix).eq(0).removeAttr('disabled');

        //必填选项提示文字
        $(stepVerify).change(function() {
            if ($(stepVerify).is(':checked')) {
                $('.step-next-tips').hide()
            } else {
                $('.step-next-tips').show()
            }
        })

        //步骤跳转 只可以跳转当前步骤的向前
        $(".ui-step-item").on("click", function (e) {
            if ($(this).index() < $step.getIndex()) {
                $step.toStep($(this).index());
                stepBoxDisplay();
            }
        });

        //step5条款确认
        function confirmationItemsVerify(){
            for(var i = 0; i < confirmationVerify.length; i++){
                if($(confirmationVerify[i]).is(':checked')){
                    $(confirmationVerify[i]).siblings('strong').find('span').hide()
                }else{
                    $(confirmationVerify[i]).siblings('strong').find('span').css("display","block");
                    $(confirmationVerify).each(function() {
                        $(this).attr('disabled', 'false');
                    });
                    $(confirmationVerify[i]).removeAttr('disabled');
                    return $(confirmationVerify[i]).offset().top;
                }
            }
        }
        $(confirmationVerify).change(function(){
            confirmationItemsVerify();
        })

        //step6条款确认
        function confirmationItemsVerifySix(){
            for(var i = 0; i < confirmationVerifySix.length; i++){
                if($(confirmationVerifySix[i]).is(':checked')){
                    $(confirmationVerifySix[i]).siblings('strong').find('span').hide()
                }else{
                    $(confirmationVerifySix[i]).siblings('strong').find('span').css("display","block");
                    $(confirmationVerifySix).each(function() {
                        $(this).attr('disabled', 'false');
                    });
                    $(confirmationVerifySix[i]).removeAttr('disabled');
                    return $(confirmationVerifySix[i]).offset().top;
                }
            }
        }
        $(confirmationVerifySix).change(function(){
            confirmationItemsVerifySix();
        })

        // 确认开户
        $("#submitInfo").on("click", function () {
            if($('#RealAccountWaiverClientAccept').is(':checked')){
                $('.opne-acc-submit-tips').hide()
                var tradeExperienceCompanyName = $('#RealAccountTradeExperienceCompanyName').val();
                var programme = $('.s51-settlement_of_disputes').val();
                var court = $('#RealAccountSfftForm24PengadilanNegeri').val();
                var branch = $('#RealAccountStepFifeBranchId1').val();
                console.log(tradeExperienceCompanyName , programme,string,integer )
                $.ajax({
                    url: '/member/real_accounts/confirm',
                    async: true,
                    data: {
                        "id":userFormId,
                        "trade_experience_company":tradeExperienceCompanyName,
                        "programme":programme,
                        "court":court,
                        "branch":branch
                    },
                    type: 'post',
                    dataType: 'json',
                    contentType: "application/x-www-form-urlencoded;charset=utf-8",
                    success: function (data) {
                        if(data.status == 200){
                            layer.open({
                                content: '提交成功，请等待审核！',
                                yes: function(index, layero){
                                    //do something
                                    layer.close(index); //如果设定了yes回调，需进行手工关闭
                                    window.location.href = "/member/real_accounts/list"
                                }
                            });
                        }else {
                            layer.open({
                                content: '提交失败，请等重新提交！',
                                yes: function(index, layero){
                                    //do something
                                    layer.close(index); //如果设定了yes回调，需进行手工关闭
                                }
                            });
                        }
                    }
                });
            }else{
                $('.opne-acc-submit-tips').show();
                $('.opne-acc-submit-tips').css('display','block');
            }
        });

    }else{
        //步骤跳转 只可以跳转当前步骤的向前
        $(".ui-step-item").on("click", function (e) {
            $step.toStep($(this).index());
            stepBoxDisplay();
            window.scrollTo(0, 0);
        });
        //页面跳转下一步
        $("#nextBtn").on("click", function () {
            $step.nextStep();
            stepBoxDisplay();
            window.scrollTo(0, 0);
        });

        $(confirmationVerify).each(function() {
            $(this).attr('checked', true);
        });
        $(confirmationVerifySix).each(function() {
            $(this).attr('checked', true);
        });
        $(stepVerify).attr('checked',true);
        $(stepVerify).attr('disabled',true);
        $('#107BPK022').removeClass('hidden');
        $('.step-next-verify').css({
            "display": "block",
        });
        $('#RealAccountTradeExperienceExperienced').attr('disabled',true);
        $('#RealAccountTradeExperienceCompanyName').attr('disabled',true);
        $('.s51-settlement_of_disputes').attr('disabled',true);
        $('#RealAccountSfftForm24PengadilanNegeri').attr('disabled',true);
        $('#RealAccountStepFifeBranchId1').attr('disabled',true);
        $('#submitInfo').css({
            "background": "#64BD2E",
            "cursor": "pointer"
        });
    }

    //翻页按钮
    function stepBoxDisplay() {
        $(stepBox).css("display", "none");
        $(stepBox[$step.getIndex()]).css("display", "block");
        if ($step.getIndex() == 0) {
            $('#prevBtn').css({
                "background": "#dad9d9",
                "cursor": "not-allowed"
            });
            $('#nextBtn').css({
                "background": "#64BD2E",
                "cursor": "pointer",
                "display": "block"
            });
            $('#submitInfo').css({
                "display": "none",
            });
        } else if ($step.getIndex() == 8) {
            $('#nextBtn').css({
                "display": "none",
            });
            $('#submitInfo').css({
                "display": "block",
                "float": "right",
            });
            $('.step-next-verify').css({
                "display": "none",
            });
            $('#prevBtn').css({
                "background": "#64BD2E",
                "cursor": "pointer"
            });
        } else if ($step.getIndex() == 2) {
            $('.step-next-verify').css({
                "display": "none",
            });
        } else {
            $('#prevBtn').css({
                "background": "#64BD2E",
                "cursor": "pointer"
            });
            $('#nextBtn').css({
                "background": "#64BD2E",
                "cursor": "pointer",
                "display": "block"
            });
            $('#submitInfo').css({
                "display": "none",
            });
            $('.step-next-verify').css({
                "display": "block",
            });
        }


    }

    //
    $('#RealAccountWaiverClientAccept').change(function(){
        if($('#RealAccountWaiverClientAccept').is(':checked')){
            $('#submitInfo').css({
                "background": "#64BD2E",
                "cursor": "pointer",
            })
        }else{
            $('#submitInfo').css({
                "background": "#dad9d9",
                "cursor": "not-allowed",
            });
        }
    })

    //RealAccountTradeExperienceExperienced
    $('#RealAccountTradeExperienceExperienced').change(function () {
        if ($('#RealAccountTradeExperienceExperienced').val() && $('#RealAccountTradeExperienceExperienced').val() == 1) {
            $('#107BPK022').removeClass('hidden');
            $('.step-next-verify').css({
                "display": "block",
            });
            $('.step-next-tips').hide();
        } else if ($('#RealAccountTradeExperienceExperienced').val() == 0) {
            $('#107BPK022').addClass('hidden');
            $('.step-next-verify').css({
                "display": "none",
            });
        }
    });
    $('#RealAccountTradeExperienceCompanyName').blur(function () {
        if ($('#RealAccountTradeExperienceCompanyName').val()){
            $('.five-step-next-tips').hide();
        }
    });


</script>

{% endblock %}
