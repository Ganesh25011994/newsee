import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:newsee/widgets/custom_text_field.dart';
import 'package:newsee/widgets/drop_down.dart';
import 'package:newsee/widgets/integer_text_field.dart';
import 'package:newsee/widgets/searchable_drop_down.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LeadDetailsView extends StatelessWidget {
  LeadDetailsView({super.key});

  final form = FormGroup({
    'businessdescription': FormControl<String>(
      validators: [Validators.required],
    ),
    'sourcingchannel': FormControl<String>(validators: [Validators.required]),
    'sourcingid': FormControl<String>(validators: [Validators.required]),
    'sourcingname': FormControl<String>(validators: [Validators.required]),
    'preferredbranch': FormControl<String>(validators: [Validators.required]),
    'branchcode': FormControl<String>(validators: [Validators.required]),
    'leadgeneratedby': FormControl<String>(validators: [Validators.required]),
    'leadid': FormControl<String>(validators: [Validators.required]),
    'customername': FormControl<String>(validators: [Validators.required]),
    'dateofbirth': FormControl<String>(validators: [Validators.required]),
    'mobilenumber': FormControl<String>(validators: [Validators.required]),
    'productinterest': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Accordion(
          scaleWhenAnimating: false,
          openAndCloseAnimation: true,
          children: [
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: const Color(0XFF229e82),
              headerBorderWidth: 1,
              headerBorderColor: Colors.greenAccent,
              rightIcon: const Icon(
                Icons.pending, 
                color: Colors.white,
              ),
              header: Center(
                child: Text(
                  "Sourcing Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              contentBorderColor: const Color.fromARGB(255, 5, 253, 216),
              contentBorderWidth: 3,
              content: ReactiveForm(
                formGroup: form,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Dropdown(
                          controlName: 'businessdescription',
                          label: 'Business Description',
                          items: ['MSME', 'Retail'],
                        ),
                        Dropdown(
                          controlName: 'sourcingchannel',
                          label: 'Sourcing Channel',
                          items: [
                            'Direct Call',
                            'Lead Management System',
                            'Online',
                            'Partner',
                            'Website',
                          ],
                        ),
                        IntegerTextField('sourcingid', 'Sourcing ID'),
                        CustomTextField('sourcingname', 'Sourcing Name'),
                        SearchableDropdown(
                          controlName: 'preferredbranch',
                          label: 'Preferred Branch',
                          items: [
                            'AMTA',
                            'ASHOKENAGAR',
                            'BADU',
                            'BAGMORE',
                            'BAGNAN',
                            'BAGUIATI-KOLKATA',
                            'BAKSHARA-HOWRAH',
                            'BAKULTALA',
                            'BALLY GOSWAMIPARA',
                            'BALTIKURI-HOWRAH',
                            'BAMUNGACHI',
                            'BANIPUR',
                            'BANITABLA',
                            'BANKRA-HOWRAH',
                            'BARASAT',
                            'BARGACHIA',
                            'BEGRI',
                            'BELGHARIA',
                            'BELIAGHATA BRIDGE',
                            'BELLILIOUS ROAD',
                            'BESU',
                            'BINDHANNAGAR',
                            'BILKANDA',
                            'BONGAON',
                            'CHANDPORE',
                            'DAKSHIN JHAPARDA',
                            'DAKSHIN JOYPUR',
                            'DAKSHINESWAR',
                            'DUM DUM-KOLKATA',
                            'GARIA-KOLKATA',
                            'HABRA',
                          ],
                        ),
                        IntegerTextField('branchcode', 'Branch Code'),
                        IntegerTextField('leadgeneratedby', 'Lead Generated By'),
                        IntegerTextField('leadid', 'Lead ID'),
                        CustomTextField('customername', 'Customer Name'),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ReactiveTextField<String>(
                            formControlName: 'dateofbirth',
                            validationMessages: {
                              ValidationMessage.required:
                                  (error) => 'Date of Birth is required',
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Date Of Birth',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: (control) async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().subtract(
                                  Duration(days: 365 * 18),
                                ),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                final formatted =
                                    "${pickedDate.day.toString().padLeft(2, '0')}/"
                                    "${pickedDate.month.toString().padLeft(2, '0')}/"
                                    "${pickedDate.year}";
                                form.control('dateofbirth').value = formatted;
                              }
                            },
                          ),
                        ),
                        IntegerTextField('mobilenumber', 'Mobile Number'),
                        SearchableDropdown(
                          controlName: 'productinterest',
                          label: 'Product Interest',
                          items: [
                            'Car Loan',
                            'Cash Loan',
                            'Combo Car Loan',
                            'Corporate Car Loan',
                            'Corporate Home Loan',
                            'Educational Loan',
                            'Housing Loan',
                            'Pensioner Loan',
                            'Property Loan',
                            'Rent Loan',
                            'UCO Survodaya Loan Scheme',
                            'Two Wheeler Loan',
                            'UCO Electric Vehicle Loan',
                            'UCO Electric Vehicle EV Loan',
                            'UCO Elite Two Wheeler Loan',
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (form.valid) {
                                //

                                final tabController = DefaultTabController.of(context);
                                if (tabController.index < tabController.length - 1) {
                                  tabController.animateTo(tabController.index + 1);
                                }
                              } else {
                                form.markAllAsTouched();
                              }
                            },
                            child: Text('Next'),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              )
            ),
            AccordionSection(
              isOpen: false,
              rightIcon: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Icon(Icons.check, color: Colors.green, size: 12,),
              ),
              
              header: Center(
                child: Text(
                  "Second Accordian Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              content: Text("Worst fellow")
            ),
            AccordionSection(
              header: Center(
                child: Text(
                  "Third Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              content: Text("Worst fellow")
            ),
            AccordionSection(
              header: Center(
                child: Text(
                  "Fourth Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              content: Text("Worst fellow")
            ),
            AccordionSection(
              header: Center(
                child: Text(
                  "fifth Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              content: Text("Worst fellow")
            )
          ]
        ),
      )
    );
  }
}