# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by chef-codegen and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

module Google
  module Storage
    module Data
      # A class to manage data for lifecycle for bucket.
      class BucketLifecycle
        include Comparable

        attr_reader :rule

        def to_json(_arg = nil)
          {
            'rule' => rule
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            rule: ['[',
                   rule.map(&:to_json).join(', '),
                   ']'].join(' ')
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? BucketLifecycle
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? BucketLifecycle
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        def inspect
          to_json
        end

        private

        def compare_fields(other)
          [
            { self: rule, other: other.rule }
          ]
        end
      end

      # Manages a BucketLifecycle nested object
      # Data is coming from the GCP API
      class BucketLifecycleApi < BucketLifecycle
        def initialize(args)
          @rule =
            Google::Storage::Property::BucketRuleArray.api_parse(args['rule'])
        end
      end

      # Manages a BucketLifecycle nested object
      # Data is coming from the Chef catalog
      class BucketLifecycleCatalog < BucketLifecycle
        def initialize(args)
          @rule = Google::Storage::Property::BucketRuleArray.catalog_parse(
            args[:rule]
          )
        end
      end
    end

    module Property
      # A class to manage input to lifecycle for bucket.
      class BucketLifecycle
        def self.coerce
          lambda do |x|
            ::Google::Storage::Property::BucketLifecycle.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::BucketLifecycle
          Data::BucketLifecycleCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::BucketLifecycle
          Data::BucketLifecycleApi.new(value)
        end
      end
    end
  end
end
