{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
      integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
{% endblock %}

{% set myselect =  Lang.select.member.customer %}
{% set registerInfo =  Lang.select.member.register %}

{% block content %}

    <div class="main_content">
        <div class="main_content_holder">
            {% if userDatas.open_account_info.nationality != "" %}
                <div class="tab-pane" id="RealAccountWizardTab4">
                <div class="row">
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
                                        {{ userDatas.full_name }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-5 col-sm-12 control-label">
                                    Tempat, Tgl Lahir
                                </label>
                                <div class="col-md-7 col-sm-12">
                                    <p class="form-control-static">
                                        {{userDatas.open_account_info.place }} {{ userDatas.open_account_info.birthday | date('Y-m-d') }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-5 col-sm-12 control-label">
                                    ID
                                </label>
                                <div class="col-md-7 col-sm-12">
                                    <p class="form-control-static">
                                        {% set marStatus = {} %}
                                        {% for item in Lang.select.member.register.identity_type_map  %}
                                        {% set marStatus[item.value] = item.label %}
                                        {% endfor %}
                                        {{ marStatus[ userDatas.open_account_info.identity_type ] }}
                                        /
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
                                        {% set marStatus = {} %}
                                        {% for item in Lang.select.member.register.experience  %}
                                        {% set marStatus[item.value] = item.label %}
                                        {% endfor %}
                                        {{ marStatus[ userDatas.open_account_info.investment_experience ] }}
                                        /
                                        {{ userDatas.open_account_info.investment_experience_desc }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-5 col-sm-12 control-label">
                                    Tuj. Buka Rekening
                                </label>
                                <div class="col-md-7 col-sm-12">
                                    <p class="form-control-static">
                                        {% if userDatas.open_account_info.purpose_of_account_opening == 3 %}
                                        {{ userDatas.open_account_info.purpose_of_account_opening_other }}
                                        {% else %}
                                        {% set marStatus = {} %}
                                        {% for item in Lang.select.member.register.purpose_of_account_opening  %}
                                        {% set marStatus[item.value] = item.label %}
                                        {% endfor %}
                                        {{ marStatus[ userDatas.open_account_info.purpose_of_account_opening ] }}
                                        {% endif %}

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
                                        {% set marStatus = {} %}
                                        {% for item in Lang.select.member.register.gender  %}
                                        {% set marStatus[item.value] = item.label %}
                                        {% endfor %}
                                        {{ marStatus[ userDatas.open_account_info.gender ] }}
                                    </p>
                                </div>
                            </div>

                            <div class="step-2-formulir-items">
                                <label class="col-md-5 col-sm-12 control-label">
                                    Tidak kawin
                                </label>
                                <div class="col-md-7 col-sm-12">
                                    <p class="form-control-static">
                                        {% set marStatus = {} %}
                                        {% for item in Lang.select.member.register.marital_status  %}
                                        {% set marStatus[item.value] = item.label %}
                                        {% endfor %}
                                        {{ marStatus[userDatas.open_account_info.marital_status] }}
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
                                    Kewarganegaraan
                                </label>
                                <div class="col-md-7 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.nationality }}
                                    </p>
                                </div>
                            </div>

                            <div class="step-2-formulir-items">
                                <label class="col-md-5 col-sm-12 control-label">
                                    Kode Pos
                                </label>
                                <div class="col-md-7 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.postal_code }}
                                    </p>
                                </div>
                            </div>

                            <div class="step-2-formulir-items">
                                <label class="col-md-5 col-sm-12 control-label">
                                    Status Rumah
                                </label>
                                <div class="col-md-7 col-sm-12">
                                    <p class="form-control-static">

                                        {% if userDatas.open_account_info.house_ownership == 3 %}
                                        {{ userDatas.open_account_info.house_ownership_other }}
                                        {% else %}
                                        {% set marStatus = {} %}
                                        {% for item in Lang.select.member.register.house_ownership  %}
                                        {% set marStatus[item.value] = item.label %}
                                        {% endfor %}
                                        {{ marStatus[ userDatas.open_account_info.house_ownership ] }}
                                        {% endif %}

                                    </p>
                                </div>
                            </div>

                            <div class="step-2-formulir-items">
                                <label class="col-md-5 col-sm-12 control-label">
                                    No. Telp Rumah
                                </label>
                                <div class="col-md-7 col-sm-12">
                                    <p class="form-control-static">
                                        + {{  userDatas.open_account_info.house_number_country_code }} - {{ userDatas.open_account_info.house_facsimile_number }}
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
                                           disabled="disabled" value="0"
                                           {% if userDatas.open_account_info.have_family_in == 0 %}
                                           checked="checked"
                                           {% endif %}
                                    >
                                    Tidak
                                </label>
                                <label class="radio-inline">
                                    <input type="radio"
                                           name="data[RealAccountProfile][have_family_in]"
                                           id="RealAccountProfileHaveFamilyIn1"
                                           disabled="disabled"
                                           {% if userDatas.open_account_info.have_family_in == 1 %}
                                           checked="checked"
                                           {% endif %}
                                           value="1">
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
                                           disabled="disabled" value="0"
                                           {% if userDatas.open_account_info.bankruptcy == 0 %}
                                           checked="checked"
                                           {% endif %}
                                    >
                                    Tidak
                                </label>
                                <label class="radio-inline">
                                    <input type="radio"
                                           name="data[RealAccountProfile][bankruptcy]"
                                           id="RealAccountProfileBankruptcy1"
                                           disabled="disabled"
                                           {% if userDatas.open_account_info.bankruptcy == 1 %}
                                           checked="checked"
                                           {% endif %}
                                           value="1"
                                    >
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
                                        + {{ userDatas.open_account_info.emergency_contact.country_code }} - {{ userDatas.open_account_info.emergency_contact.phone_number }}
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
                                        {% if userDatas.open_account_info.open_account_job.occupation == 6 %}
                                        {{ userDatas.open_account_info.open_account_job.occupation_other }}
                                        {% else %}
                                        {% set marStatus = {} %}
                                        {% for item in Lang.select.member.register.occupation  %}
                                        {% set marStatus[item.value] = item.label %}
                                        {% endfor %}
                                        {{ marStatus[ userDatas.open_account_info.open_account_job.occupation ] }}
                                        {% endif %}
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
                                        {{ userDatas.open_account_info.open_account_job.business_field }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Jabatan
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_job.title }}
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
                                        {{ userDatas.open_account_info.open_account_job.length_of_services_in_previous_office }}
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
                                        + {{ userDatas.open_account_info.open_account_job.phone_country_code }} - {{ userDatas.open_account_info.open_account_job.office_phone_number }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Fax Kantor
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        + {{ userDatas.open_account_info.open_account_job.fax_country_code }} - {{ userDatas.open_account_info.open_account_job.office_fax_number }}
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
                                        {% set marStatus = {} %}
                                        {% for item in Lang.select.member.register.annual_income  %}
                                        {% set marStatus[item.value] = item.label %}
                                        {% endfor %}
                                        {{ marStatus[ userDatas.open_account_info.open_account_wealth_list.annual ] }}

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
                                    <p class="form-control-static wealth_house_tax_value">
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
                                    <p class="form-control-static wealth_time_deposit">
                                        {{ userDatas.open_account_info.open_account_wealth_list.time_deposit }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Jumlah
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static wealth_total">
                                        {{ userDatas.open_account_info.open_account_wealth_list.total }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Lainnya
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static wealth_others">
                                        {{ userDatas.open_account_info.open_account_wealth_list.others }}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <h4>&nbsp;</h4>
                    <div class="col-md-12 col-sm-12">
                        <h4>Bank(IDR)</h4>
                        <hr>
                        <div class="col-md-6 col-sm-12">
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Nama Bank</label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[0].bank_name }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Cabang
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[0].branch }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Nomor Telepon
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        +{{ userDatas.open_account_info.open_account_bank[0].country_code }}-{{ userDatas.open_account_info.open_account_bank[0].phone_name }}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Nomor Account
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[0].account_number }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Swift Code
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[0].branch_swift_code }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Atas Nama
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[0].account_name }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Jenis Tabungan
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {% if userDatas.open_account_info.open_account_bank[0].account_type == 2 %}
                                        {{ Lang.select.member.register.bank_account_type[ userDatas.open_account_info.open_account_bank[0].account_type ].label }} / {{ userDatas.open_account_info.open_account_bank[0].account_other }}
                                        {% else %}
                                        {{ Lang.select.member.register.bank_account_type[ userDatas.open_account_info.open_account_bank[0].account_type ].label }}
                                        {% endif %}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    {% if userDatas.open_account_info.open_account_bank[1].bank_name !== "" %}
                    <h4>&nbsp;</h4>
                    <div class="col-md-12 col-sm-12">
                        <h4>Bank(USD)</h4>
                        <hr>
                        <div class="col-md-6 col-sm-12">
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Nama Bank</label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[1].bank_name }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Cabang
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[1].branch }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Nomor Telepon
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        +{{ userDatas.open_account_info.open_account_bank[1].country_code }}-{{ userDatas.open_account_info.open_account_bank[1].phone_name }}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Nomor Account
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[1].account_number }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Swift Code
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[1].branch_swift_code }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Atas Nama
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {{ userDatas.open_account_info.open_account_bank[1].account_name }}
                                    </p>
                                </div>
                            </div>
                            <div class="step-2-formulir-items">
                                <label class="col-md-4 col-sm-12 control-label">
                                    Jenis Tabungan
                                </label>
                                <div class="col-md-8 col-sm-12">
                                    <p class="form-control-static">
                                        {% if userDatas.open_account_info.open_account_bank[1].account_type == 2 %}
                                        {{ Lang.select.member.register.bank_account_type[ userDatas.open_account_info.open_account_bank[1].account_type ].label }} / {{ userDatas.open_account_info.open_account_bank[1].account_other }}
                                        {% else %}
                                        {{ Lang.select.member.register.bank_account_type[ userDatas.open_account_info.open_account_bank[1].account_type ].label }}
                                        {% endif %}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    {% endif %}
                </div>
            </div>
            {% else %}
                <div style="margin-top:30px;text-align: center; font-size: 14px">{{ Lang.tips_no_info_yet ||"暂无信息"}}</div>
                <div style="margin-top:30px;text-align: center">
                    <a class="layui-btn" href="/member/real_accounts/list"  id="openBtn">{{ Lang.real_account_apply_btn || "申请开设账户" }}</a>
                </div>
            {% endif %}
        </div>`
    </div>
{% endblock %}

{% block js_assets %}

<script type="text/javascript">
    $(document).ready(function () {
        wealthOthers();
        wealthTotal();
        wealthTimeDeposit();
        wealthHouseTaxValue();
    });
    function wealthOthers(){
        var textNumber = $('.wealth_others').text().trim();
        $('.wealth_others').text(toThousands(textNumber));
    }
    function wealthTotal(){
        var textNumber = $('.wealth_total').text().trim();
        $('.wealth_total').text(toThousands(textNumber));
    }
    function wealthTimeDeposit(){
        var textNumber = $('.wealth_time_deposit').text().trim();
        $('.wealth_time_deposit').text(toThousands(textNumber));
    }
    function wealthHouseTaxValue(){
        var textNumber = $('.wealth_house_tax_value').text().trim();
        $('.wealth_house_tax_value').text(toThousands(textNumber));
    }

    //数字千位符格式化
    function toThousands(Id) {
        value = Id.toString().replace(/,/g,'');
        var num = (value || 0).toString(), result = '';
        while (num.length > 3) {
            result = ',' + num.slice(-3) + result;
            num = num.slice(0, num.length - 3);
        }
        if (num) {
            result = num + result;
        }
        return result;
    }
</script>

{% endblock %}


