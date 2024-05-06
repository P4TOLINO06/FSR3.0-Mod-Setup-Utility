// ---- FNV Hash d792eab52443a73a

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:07:12 2023
Texture2D<float4> t8 : register(t8);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t3 : register(t3);

SamplerState s8_s : register(s8);

SamplerState s7_s : register(s7);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s3_s : register(s3);

cbuffer cb9 : register(b9)
{
  float4 cb9[7];
}

cbuffer cb11 : register(b11)
{
  float4 cb11[4];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[4];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[50];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[14];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
  row_major float4x4 gWorldViewProjUnjittered;
  row_major float4x4 gWorldViewProjUnjitteredPrev;
}

// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float3 v6 : TEXCOORD5,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb9[3].zw + -cb9[3].xy;
  r0.xy = float2(8,1) / r0.xy;
  r0.zw = saturate(-cb9[3].xy + v1.xy);
  r1.xy = r0.zw * r0.xy;
  r1.xy = trunc(r1.xy);
  r0.xy = r0.zw * r0.xy + -r1.xy;
  r0.z = (int)r1.x;
  r1.xyzw = cmp((int4)r0.zzzz == int4(0,1,2,3));
  r2.xyzw = cmp((int4)r0.zzzz == int4(4,5,6,7));
  r2.xyzw = r2.xyzw ? float4(1,1,1,1) : 0;
  r0.z = dot(cb9[1].xyzw, r2.xyzw);
  r1.xyzw = r1.xyzw ? float4(1,1,1,1) : 0;
  r0.w = dot(cb9[0].xyzw, r1.xyzw);
  r0.z = r0.w + r0.z;
  r0.z = trunc(r0.z);
  r0.z = r0.z / cb9[2].z;
  r0.w = trunc(r0.z);
  r1.x = r0.z + -r0.w;
  r1.y = r0.w / cb9[2].w;
  r0.xy = r0.xy * cb9[2].xy + r1.xy;
  r0.zw = ddx_coarse(v1.xy);
  r0.zw = float2(0.5,0.5) * r0.zw;
  r1.xy = ddy_coarse(v1.xy);
  r1.xy = float2(0.5,0.5) * r1.xy;
  r1.z = t7.SampleGrad(s7_s, r0.xy, r0.z, r1.x).x;
  r0.xy = t8.SampleGrad(s8_s, r0.xy, r0.zw, r1.xy).xy;
  r0.zw = max(abs(r1.xy), abs(r0.zw));
  r0.z = max(r0.z, r0.w);
  r0.zw = cb9[6].xy * r0.zz;
  r0.zw = max(cb9[6].zw, r0.zw);
  r1.xy = cmp(v1.xy < cb9[3].xy);
  r1.xy = r1.xy ? float2(1,1) : 0;
  r2.xy = cmp(cb9[3].zw < v1.xy);
  r2.xy = r2.xy ? float2(1,1) : 0;
  r3.xy = cmp(float2(0,0) != r1.xy);
  r3.zw = cmp(float2(0,0) != r2.xy);
  r2.xyzw = r3.xyzw ? float4(1,1,1,1) : 0;
  r1.x = dot(r2.xyzw, r2.xyzw);
  r1.x = min(1, r1.x);
  r1.y = r1.x * -r1.z + r1.z;
  r0.xy = r1.xx * -r0.xy + r0.xy;
  r0.xy = float2(-0.5,-0.5) + r0.xy;
  r0.xy = cb9[5].xx * r0.xy;
  r0.z = cb9[5].y + -r0.z;
  r0.w = cb9[5].y + r0.w;
  r0.w = r0.w + -r0.z;
  r0.z = r1.y + -r0.z;
  r0.w = 1 / r0.w;
  r0.z = saturate(r0.z * r0.w);
  r0.w = r0.z * -2 + 3;
  r0.z = r0.z * r0.z;
  r0.z = r0.w * r0.z;
  r1.xyzw = t5.Sample(s5_s, v1.xy).xyzw;
  r2.xyz = cb9[4].www * cb9[4].xyz + -r1.xyz;
  r2.xyz = r0.zzz * r2.xyz + r1.xyz;
  r1.xyz = cb11[0].xyz * r2.xyz;
  r1.xyzw = v3.xxxw * r1.xyzw;
  r2.xyz = cb11[3].xyz * cb11[2].yyy;
  r2.xyz = r2.xyz * float3(1.07558298,0.994183481,0.930233717) + -r1.xyz;
  r0.w = cb11[2].z * cb5[3].z;
  r3.xy = -cb11[2].zz + float2(1,2);
  r3.yz = v1.zw * r3.yy;
  r4.xyz = t3.Sample(s3_s, r3.yz).xyz;
  r2.w = t3.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r3.w = cmp(0.49000001 < r2.w);
  r2.w = cmp(r2.w < 0.50999999);
  r2.w = r2.w ? r3.w : 0;
  r3.w = saturate(cb11[2].y * 2.5 + -1.5);
  r4.w = r4.x * r3.w;
  r5.y = 1.29999995 * r4.w;
  r5.z = r4.y;
  r5.yz = r2.ww ? r5.yz : r4.yz;
  r2.w = r5.z + -r4.x;
  r5.x = r0.w * r2.w + r4.x;
  r4.xy = cb11[2].xx * r5.xy;
  r0.w = v3.z * r3.x;
  r2.w = v3.z * r3.x + -1;
  r2.w = r3.x * r2.w + 1;
  r0.w = cb11[2].x * r0.w;
  r3.x = r2.w * r4.x;
  r2.w = -r4.y * r2.w + 1;
  r1.xyz = r3.xxx * r2.xyz + r1.xyz;
  o0.w = cb2[12].x * r1.w;
  r2.xyz = r5.zzz + -r1.xyz;
  r1.xyz = r0.www * r2.xyz + r1.xyz;
  r2.xy = t6.Sample(s6_s, v1.xy).xy;
  r0.xy = r0.xy * r0.zz + r2.xy;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.z = dot(r0.xy, r0.xy);
  r0.z = 1 + -r0.z;
  r0.z = sqrt(abs(r0.z));
  r0.w = max(cb11[3].w, 0.00100000005);
  r0.xy = r0.xy * r0.ww;
  r4.xyzw = v6.zxyz * r0.yyyy;
  r4.xyzw = r0.xxxx * v5.zxyz + r4.xyzw;
  r0.xyzw = r0.zzzz * v2.zxyz + r4.xyzw;
  r1.w = dot(r0.yzw, r0.yzw);
  r1.w = rsqrt(r1.w);
  r0.yzw = r1.www * r0.yzw;
  r0.x = r0.x * r1.w + -0.349999994;
  r0.yzw = r0.yzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r1.w = cmp(cb11[2].y < 1);
  if (r1.w != 0) {
    r2.xy = cmp(r3.yz < float2(1.09333301,1.75999999));
    r1.w = r2.y ? r2.x : 0;
    r2.xy = r3.yz * float2(0.75,0.75) + float2(-1,-1);
    r2.xy = float2(4.0999999,4.0999999) * r2.xy;
    r2.z = -r2.y;
    r3.x = dot(r2.xz, float2(-4.37113883e-08,-1));
    r3.y = dot(r2.xz, float2(1,-4.37113883e-08));
    r4.xyzw = float4(0.699999988,0.699999988,0.699999988,0.699999988) * r3.xyyx;
    r4.xyzw = r1.wwww ? r4.xyzw : r2.xzzx;
    r2.xy = float2(1,1.5) + -r3.ww;
    r1.w = 0.666666687 * r2.y;
    r2.y = r2.y * -1.33333302 + 3;
    r1.w = r1.w * r1.w;
    r1.w = dot(r2.yy, r1.ww);
    r2.x = r2.x + r2.x;
    r2.x = min(1, r2.x);
    r2.y = r2.x * -2 + 3;
    r2.x = r2.x * r2.x;
    r2.x = r2.y * r2.x;
    r3.xyzw = float4(0.00100000005,0,0.00100000005,0) + r4.xyzw;
    r4.xyz = float3(22.2000008,37,18.5) * r3.xyy;
    r2.y = cb2[13].x * 0.00374999992;
    r2.z = r3.y * 1.85000002 + r2.y;
    r4.x = floor(r4.x);
    r4.x = 12345.5596 * r4.x;
    r4.xy = sin(r4.xy);
    r4.x = 7658.75977 * r4.x;
    r4.x = frac(r4.x);
    r5.y = r4.x + r2.z;
    r5.xz = r3.xw;
    r4.xw = float2(22.2000008,2) * r5.xy;
    r5.xy = floor(r4.xw);
    r2.z = dot(r5.xy, float2(35.2000008,2376.1001));
    r6.xyz = float3(0.103100002,0.113689996,0.137869999) * r2.zzz;
    r6.xyz = frac(r6.xyz);
    r7.xyz = float3(19.1900005,19.1900005,19.1900005) + r6.yzx;
    r2.z = dot(r6.xyz, r7.xyz);
    r6.xyz = r6.xyz + r2.zzz;
    r5.xy = r6.xy + r6.yz;
    r5.xy = r5.xy * r6.zx;
    r5.xy = frac(r5.xy);
    r6.xy = frac(r4.xw);
    r2.z = -1 + r6.y;
    r4.xw = float2(-0.5,-0.5) + r5.xy;
    r4.y = r3.y * 37 + r4.y;
    r4.y = sin(r4.y);
    r5.x = 0.5 + -abs(r4.x);
    r4.y = r5.x * r4.y;
    r4.x = r4.y * r4.w + r4.x;
    r7.x = 0.699999988 * r4.x;
    r4.x = cb2[13].x * 0.00499999989 + r5.y;
    r4.x = frac(r4.x);
    r4.y = 1.17647099 * r4.x;
    r4.y = min(1, r4.y);
    r4.w = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r4.w * r4.y;
    r4.x = -1 + r4.x;
    r4.x = -6.66666794 * r4.x;
    r4.x = min(1, r4.x);
    r4.w = r4.x * -2 + 3;
    r4.x = r4.x * r4.x;
    r4.x = r4.w * r4.x;
    r4.x = r4.y * r4.x + -0.5;
    r7.yz = r4.xx * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r6.zw = float2(-0.5,-0.5) + r6.xx;
    r4.xy = -r7.xy + r6.zy;
    r5.xy = float2(1,6) * r4.xy;
    r4.w = dot(r5.xy, r5.xy);
    r4.w = sqrt(r4.w);
    r4.yw = float2(0.0199999996,-0.400000006) + r4.yw;
    r4.w = -2.5 * r4.w;
    r4.w = max(0, r4.w);
    r5.x = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r5.y = 1 / r7.z;
    r2.z = saturate(r5.y * r2.z);
    r5.y = r2.z * -2 + 3;
    r2.z = r2.z * r2.z;
    r2.z = r5.y * r2.z;
    r5.y = sqrt(r2.z);
    r6.x = 0.200000003 * r5.y;
    r4.x = -r5.y * 0.200000003 + abs(r4.x);
    r6.x = 1 / -r6.x;
    r4.x = saturate(r6.x * r4.x);
    r6.x = r4.x * -2 + 3;
    r4.x = r4.x * r4.x;
    r4.x = r6.x * r4.x;
    r4.y = saturate(25 * r4.y);
    r6.x = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r6.x * r4.y;
    r2.z = r4.y * r2.z;
    r8.x = r4.x * r2.z;
    r2.z = frac(r4.z);
    r2.z = r6.y + r2.z;
    r7.w = -0.5 + r2.z;
    r4.xz = -r7.xw + r6.wy;
    r2.z = dot(r4.xz, r4.xz);
    r2.z = sqrt(r2.z);
    r2.z = -0.300000012 + r2.z;
    r2.z = -3.33333302 * r2.z;
    r2.z = max(0, r2.z);
    r4.x = r2.z * -2 + 3;
    r2.z = r2.z * r2.z;
    r2.z = r4.x * r2.z;
    r2.z = r2.z * r5.y;
    r2.z = r2.z * r4.y;
    r2.z = r5.x * r4.w + r2.z;
    r4.xyz = float3(30,30,22.2000008) * r3.xyw;
    r6.xyz = floor(r4.xyz);
    r3.xy = frac(r4.xy);
    r3.xy = float2(-0.5,-0.5) + r3.xy;
    r4.x = dot(r6.xy, float2(107.449997,3543.65405));
    r4.xyz = float3(0.137869999,0.113689996,0.103100002) * r4.xxx;
    r4.xyz = frac(r4.xyz);
    r6.xyw = float3(19.1900005,19.1900005,19.1900005) + r4.yxz;
    r4.w = dot(r4.zyx, r6.xyw);
    r4.xyz = r4.xyz + r4.www;
    r6.xyw = r4.zzy + r4.yxx;
    r4.xyz = r6.xyw * r4.xyz;
    r4.xyz = frac(r4.xyz);
    r4.xy = float2(-0.5,-0.5) + r4.xy;
    r3.xy = -r4.xy * float2(0.699999988,0.699999988) + r3.xy;
    r3.x = dot(r3.xy, r3.xy);
    r3.x = sqrt(r3.x);
    r3.x = -0.300000012 + r3.x;
    r3.x = -3.33333302 * r3.x;
    r3.x = max(0, r3.x);
    r3.y = r3.x * -2 + 3;
    r3.x = r3.x * r3.x;
    r3.x = r3.y * r3.x;
    r3.y = 10 * r4.z;
    r3.y = frac(r3.y);
    r3.x = r3.x * r3.y;
    r3.y = cb2[13].x * 0.00499999989 + r4.z;
    r3.y = frac(r3.y);
    r4.x = 40 * r3.y;
    r4.x = min(1, r4.x);
    r4.y = r4.x * -2 + 3;
    r4.x = r4.x * r4.x;
    r4.x = r4.y * r4.x;
    r3.y = -1 + r3.y;
    r3.y = -1.02564096 * r3.y;
    r3.y = min(1, r3.y);
    r4.y = r3.y * -2 + 3;
    r3.y = r3.y * r3.y;
    r3.y = r4.y * r3.y;
    r3.y = r4.x * r3.y;
    r3.x = r3.x * r3.y;
    r2.z = r2.z * r2.x;
    r2.z = r3.x * r1.w + r2.z;
    r2.z = -0.300000012 + r2.z;
    r2.z = saturate(0.588235319 * r2.z);
    r3.x = r2.z * -2 + 3;
    r2.z = r2.z * r2.z;
    r3.y = r3.x * r2.z;
    r2.y = r3.z * 1.85000002 + r2.y;
    r4.x = 12345.5596 * r6.z;
    r4.x = sin(r4.x);
    r4.x = 7658.75977 * r4.x;
    r4.x = frac(r4.x);
    r5.w = r4.x + r2.y;
    r4.xy = float2(22.2000008,2) * r5.zw;
    r4.zw = floor(r4.xy);
    r2.y = dot(r4.zw, float2(35.2000008,2376.1001));
    r5.xyz = float3(0.103100002,0.113689996,0.137869999) * r2.yyy;
    r5.xyz = frac(r5.xyz);
    r6.xyz = float3(19.1900005,19.1900005,19.1900005) + r5.yzx;
    r2.y = dot(r5.xyz, r6.xyz);
    r5.xyz = r5.xyz + r2.yyy;
    r4.zw = r5.xy + r5.yz;
    r4.zw = r4.zw * r5.zx;
    r4.zw = frac(r4.zw);
    r5.xy = frac(r4.xy);
    r2.y = -1 + r5.y;
    r4.xy = float2(-0.5,-0.5) + r4.zw;
    r6.xyzw = float4(37,18.5,30,30) * r3.zzwz;
    r3.w = sin(r6.x);
    r3.z = r3.z * 37 + r3.w;
    r3.z = sin(r3.z);
    r3.w = 0.5 + -abs(r4.x);
    r3.z = r3.z * r3.w;
    r3.z = r3.z * r4.y + r4.x;
    r7.x = 0.699999988 * r3.z;
    r3.z = cb2[13].x * 0.00499999989 + r4.w;
    r3.z = frac(r3.z);
    r3.w = 1.17647099 * r3.z;
    r3.w = min(1, r3.w);
    r4.x = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.x * r3.w;
    r3.z = -1 + r3.z;
    r3.z = -6.66666794 * r3.z;
    r3.z = min(1, r3.z);
    r4.x = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r4.x * r3.z;
    r3.z = r3.w * r3.z + -0.5;
    r7.yz = r3.zz * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r5.zw = float2(-0.5,-0.5) + r5.xx;
    r3.zw = -r7.xy + r5.zy;
    r4.xy = float2(1,6) * r3.zw;
    r4.x = dot(r4.xy, r4.xy);
    r4.x = sqrt(r4.x);
    r4.x = -0.400000006 + r4.x;
    r4.x = -2.5 * r4.x;
    r4.x = max(0, r4.x);
    r4.y = r4.x * -2 + 3;
    r4.x = r4.x * r4.x;
    r4.z = 1 / r7.z;
    r2.y = saturate(r4.z * r2.y);
    r4.z = r2.y * -2 + 3;
    r2.y = r2.y * r2.y;
    r2.y = r4.z * r2.y;
    r4.z = sqrt(r2.y);
    r4.w = 0.200000003 * r4.z;
    r3.z = -r4.z * 0.200000003 + abs(r3.z);
    r4.w = 1 / -r4.w;
    r3.z = saturate(r4.w * r3.z);
    r4.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r4.w * r3.z;
    r3.w = 0.0199999996 + r3.w;
    r3.w = saturate(25 * r3.w);
    r4.w = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.w * r3.w;
    r2.y = r3.w * r2.y;
    r8.yz = r3.zz * r2.yy;
    r9.xyz = frac(r6.yzw);
    r2.y = r9.x + r5.y;
    r7.w = -0.5 + r2.y;
    r5.xy = -r7.xw + r5.wy;
    r2.y = dot(r5.xy, r5.xy);
    r2.y = sqrt(r2.y);
    r2.y = -0.300000012 + r2.y;
    r2.y = -3.33333302 * r2.y;
    r2.y = max(0, r2.y);
    r3.z = r2.y * -2 + 3;
    r2.y = r2.y * r2.y;
    r2.y = r3.z * r2.y;
    r2.y = r2.y * r4.z;
    r2.y = r2.y * r3.w;
    r2.y = r4.y * r4.x + r2.y;
    r3.zw = floor(r6.zw);
    r4.xy = float2(-0.5,-0.5) + r9.yz;
    r3.z = dot(r3.zw, float2(107.449997,3543.65405));
    r5.xyz = float3(0.137869999,0.113689996,0.103100002) * r3.zzz;
    r5.xyz = frac(r5.xyz);
    r6.xyz = float3(19.1900005,19.1900005,19.1900005) + r5.yxz;
    r3.z = dot(r5.zyx, r6.xyz);
    r5.xyz = r5.xyz + r3.zzz;
    r6.xyz = r5.zzy + r5.yxx;
    r5.xyz = r6.xyz * r5.xyz;
    r5.xyz = frac(r5.xyz);
    r3.zw = float2(-0.5,-0.5) + r5.xy;
    r3.zw = -r3.zw * float2(0.699999988,0.699999988) + r4.xy;
    r3.z = dot(r3.zw, r3.zw);
    r3.z = sqrt(r3.z);
    r3.z = -0.300000012 + r3.z;
    r3.z = -3.33333302 * r3.z;
    r3.z = max(0, r3.z);
    r3.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r3.w * r3.z;
    r3.w = 10 * r5.z;
    r3.w = frac(r3.w);
    r3.z = r3.z * r3.w;
    r3.w = cb2[13].x * 0.00499999989 + r5.z;
    r3.w = frac(r3.w);
    r4.x = 40 * r3.w;
    r4.x = min(1, r4.x);
    r4.y = r4.x * -2 + 3;
    r4.x = r4.x * r4.x;
    r4.x = r4.y * r4.x;
    r3.w = -1 + r3.w;
    r3.w = -1.02564096 * r3.w;
    r3.w = min(1, r3.w);
    r4.y = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.y * r3.w;
    r3.w = r4.x * r3.w;
    r3.z = r3.z * r3.w;
    r2.x = r2.y * r2.x;
    r1.w = r3.z * r1.w + r2.x;
    r1.w = -0.300000012 + r1.w;
    r1.w = saturate(0.588235319 * r1.w);
    r2.x = r1.w * -2 + 3;
    r1.w = r1.w * r1.w;
    r2.y = r2.x * r1.w;
    r4.x = r2.x * r1.w + -r3.y;
    r4.yz = r3.xx * r2.zz + -r2.yy;
    r2.xyz = float3(0.0450000018,0.0450000018,0.0450000018) * r8.xyz;
    r2.xyz = min(float3(1,1,1), r2.xyz);
    r1.w = min(1, r8.x);
    r2.xyz = r2.xyz * r1.www + r4.xyz;
    r1.w = dot(v4.xyz, v4.xyz);
    r1.w = rsqrt(r1.w);
    r2.xyz = max(float3(-0.0250000004,-0.0250000004,-0.0250000004), r2.xyz);
    r1.w = 1.20000005 * r1.w;
    r1.w = max(0.150000006, r1.w);
    r1.w = min(0.899999976, r1.w);
    r2.xyz = r2.xyz * r1.www;
    r1.w = cb1[15].z + -790;
    r1.w = saturate(0.00714285718 * r1.w);
    r1.w = 1 + -r1.w;
    r0.yzw = r2.xyz * r1.www + r0.yzw;
  }
  r0.x = saturate(1.53846204 * r0.x);
  r0.x = cb5[3].z * r0.x;
  r1.w = -cb2[13].z + 1;
  r0.x = r1.w * r0.x;
  r2.xy = cb2[12].zy * v3.xx;
  r0.x = r2.x * r0.x;
  r1.w = v3.x * r2.w;
  r2.x = 0.200000003 * r1.w;
  r3.xy = r1.ww * float2(0.200000003,-0.100000001) + float2(0.400000006,1);
  r3.x = saturate(r3.x);
  r1.w = r3.y * r0.x;
  r1.w = r1.w * -0.5 + 1;
  o0.xyz = r1.www * r1.xyz;
  r2.z = 0.976562977;
  r1.xy = r3.xx * float2(0.5,0.48828131) + -r2.xz;
  r1.xy = max(float2(0,0), r1.xy);
  r1.xy = r1.xy * r0.xx + r2.xz;
  o2.xy = sqrt(r1.xy);
  r0.x = saturate(cb3[49].w + cb2[13].z);
  r1.y = r2.y * r0.x;
  r1.x = cb2[12].z * v3.x + cb3[45].w;
  r1.xy = float2(0.5,0.5) * r1.xy;
  o3.xy = sqrt(r1.xy);
  o1.xyz = r0.yzw;
  o1.w = 0;
  o2.zw = float2(0.980000019,1);
  o3.zw = float2(0,1.00188398);
  return;
}