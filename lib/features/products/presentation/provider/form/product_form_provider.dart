import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/shared/shared.dart';

import '../../../../shared/infrastructure/inputs/inputs.dart';

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final void Function(Map<String, dynamic> productLike)? onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }) : super(
          ProductFormState(
            id: product.id,
            title: TitleValidator.dirty(product.title),
            slug: Slug.dirty(product.slug),
            price: Price.dirty(product.price),
            inStock: Stock.dirty(product.stock),
            tags: product.tags.join(', '),
            sizes: product.sizes,
            gender: product.gender,
            description: product.description,
            images: product.images,
          ),
        );

  Future<bool> onFormSubmit() async {
    _touchEverything();

    if (state.isFormValid) return false;

    if (onSubmitCallback == null) return false;

    // final productLike = {
    //   ...state.toMap(),
    //   'tags': state.tags.split(',').map((e) => e.trim()).toList(),
    // };

    return true;
  }

  void _touchEverything() {
    state = state.copyWith(
        isFormValid: Formz.validate(
      [
        TitleValidator.dirty(state.title!.value),
        Slug.dirty(state.slug!.value),
        Price.dirty(state.price!.value),
        Stock.dirty(state.inStock!.value),
      ],
    ));
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      title: TitleValidator.dirty(value),
      isFormValid: Formz.validate([
        TitleValidator.dirty(value),
        Slug.dirty(state.slug!.value),
        Price.dirty(state.price!.value),
        Stock.dirty(state.inStock!.value),
      ]),
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        TitleValidator.dirty(state.title!.value),
        Slug.dirty(value),
        Price.dirty(state.price!.value),
        Stock.dirty(state.inStock!.value),
      ]),
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        TitleValidator.dirty(state.title!.value),
        Slug.dirty(state.slug!.value),
        Price.dirty(value),
        Stock.dirty(state.inStock!.value),
      ]),
    );
  }

  void onStockChanged(int value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isFormValid: Formz.validate([
        TitleValidator.dirty(state.title!.value),
        Slug.dirty(state.slug!.value),
        Price.dirty(state.price!.value),
        Stock.dirty(value),
      ]),
    );
  }

  void onSizeChanged(List<String> sizes) {
    state = state.copyWith(sizes: sizes);
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }
}

class ProductFormState {
  final bool isFormValid;
  final String? id;
  final TitleValidator? title;
  final Slug? slug;

  final Price? price;

  final List<String> sizes;

  final String? gender;

  final Stock? inStock;

  final String? description;

  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const TitleValidator.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.inStock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    TitleValidator? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        sizes: sizes ?? this.sizes,
        gender: gender ?? this.gender,
        inStock: inStock ?? this.inStock,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );
}
