-- Classifcation
select prepay_voluntary, loan_identifier,  b.value as Unempl_Rate, c.US_NSA as HPI, d.PMMS30 as Rate_30YR, e.Yield, original_interest_rate, prev_month_loan_factor, original_upb, 
dti, original_ltv, borrower_credit_score_at_origination, number_of_borrowers, channel, property_type, occupancy_status,  alternative_delinquency_resolution, property_valuation_method
from lwds.prod.fannie_sf_performance_2022_q2 a
join lwds.prod.econ_bls b
  on a.as_of_date = b.as_of_date
  and b.series = 'Unemployment Rate'
join lwds.prod.econ_fhfa_hpi c
  on a.as_of_date = c.as_of_date
join lwds.prod.econ_pmms d
  on a.as_of_date = d.as_of_date
join lwds.prod.econ_treasury_yield_10yr_cmt e
  on a.as_of_date = e.as_of_date
where a.as_of_date >= '2021-01-01' and a.as_of_date < '2022-01-01'
and latest_record = 1
and property_state = 'MI'
and prev_month_loan_factor > .5
and prepay_involuntary <> 1;

-- Regression
with 
cte_pmms as(
select *
from lwds.prod.ECON_PMMS
),
cte_hpi as(
select *
from lwds.prod.econ_fhfa_hpi
)
select a.ORIGINATION_DATE, 
count(*) as PRODUCTION,
b.PMMS30_LAG1, b.PMMS30_LAG2, b.PMMS30_LAG3, 
c.US_NSA_LAG1, c.US_NSA_LAG2, c.US_NSA_LAG3, 
avg(loan_to_value_ltv) as LTV_AVG,
avg(a.original_interest_rate*100 - b.PMMS30) as RATE_DELTA
from lwds.prod.FANNIE_FREDDIE_SF_CURRENT a
left join cte_pmms b
  on a.origination_date = b.as_of_date
left join cte_hpi c
  on a.origination_date = c.as_of_date
where origination_date between '2019-05-01' and '2022-03-01'
-- May 2019 is the beginning of the reporting data we have
-- We stop short of the last month due to the securitization lag
and initial_record = 1
and LOAN_PURPOSE in ('Refinance - No Cash Out', 'Refinance - Cash Out', 'Refinance - Not Specified')
group by 1,3,4,5,6,7,8
order by 1;