import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/injection/injection.dart';
import '../../../../../shared/extensions/build_context_extension.dart';
import '../../../../../shared/fluid/fluid_box.dart';
import '../../../../../shared/fluid/fluid_text.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/theme/app_dim.dart';
import '../../../forms/primary_text_form_field.dart';
import '../application/country_picker_cubit.dart';
import '../application/country_picker_state.dart';
import '../data/model/country/country_model.dart';

class CountryModal extends StatefulWidget {
  final ValueChanged<CountryModel> selectedCountry;
  final String? code;

  const CountryModal({required this.selectedCountry, super.key, this.code});

  @override
  State<CountryModal> createState() => _CountryModalState();
}

class _CountryModalState extends State<CountryModal> {
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => locator<CountryPickerCubit>(param1: widget.code),
    child: Builder(
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(left: ctx.devicePadding, right: ctx.devicePadding),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(ctx).height * 0.8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppDim.d20, bottom: AppDim.d8),
                  child: FluidText(
                    minFontSize: AppDim.d18,
                    maxFontSize: AppDim.d20,
                    ctx.tr('choose_country'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppDim.d16),
                  child: PrimaryTextFormField(
                    controller: _search,
                    maxLines: 1,
                    autoFocus: false,
                    onChanged: ctx.read<CountryPickerCubit>().onSearch,
                    hintText: ctx.tr('hint.search_country'),
                    filled: true,
                    fillColor: AppColors.fillLightPurple,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDim.textFieldRadius),
                      borderSide: const BorderSide(color: AppColors.primaryBorder),
                    ),
                  ),
                ),
                BlocBuilder<CountryPickerCubit, CountryPickerState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 300),
                        child: const Center(child: CupertinoActivityIndicator()),
                      );
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: AppDim.d4, bottom: context.deviceSafePadding.bottom + AppDim.d24),
                        shrinkWrap: true,
                        itemCount: state.filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = state.filteredCountries[index];
                          final isSelected = country.code == state.selectedCountry?.code;

                          return AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await context
                                        .read<CountryPickerCubit>()
                                        .selectCountry(country, widget.selectedCountry)
                                        .then((_) async => context.mounted ? await context.router.maybePop() : null);
                                  },
                                  borderRadius: BorderRadius.circular(AppDim.d4),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: AnimatedDefaultTextStyle(
                                            duration: const Duration(milliseconds: 300),
                                            style: TextStyle(
                                              color: isSelected ? AppColors.secondary : AppColors.textBlack,
                                              fontSize: 18, // Use the maxFontSize for consistency
                                              fontWeight: FontWeight.w400,
                                            ),
                                            child: FluidText(
                                              minFontSize: 16,
                                              maxFontSize: 18,
                                              '${country.name} ( ${country.code})',
                                            ),
                                          ),
                                        ),
                                        _CustomRadioButton(isSelected: isSelected, activeColor: AppColors.secondary),
                                        const Gap(AppDim.d8),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isSelected) ...[
                                  const Gap(AppDim.d8),
                                  const Divider(color: AppColors.primaryBorder, height: 1),
                                ],
                                const Gap(AppDim.d8),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                Gap(ctx.bottomInset),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final Color activeColor;

  const _CustomRadioButton({required this.isSelected, this.activeColor = Colors.blue});

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: isSelected ? activeColor : AppColors.primaryBorder, width: 2),
      color: Colors.transparent,
    ),
    child: FluidBox.square(
      minSize: 16,
      maxSize: 18,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isSelected
              ? LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: constraints.maxWidth * 0.5,
                    height: constraints.maxHeight * 0.5,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: activeColor),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    ),
  );
}
