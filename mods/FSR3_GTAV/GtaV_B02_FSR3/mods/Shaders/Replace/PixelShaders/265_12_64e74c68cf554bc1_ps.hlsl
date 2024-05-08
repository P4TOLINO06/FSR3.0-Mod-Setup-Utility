// ---- FNV Hash 64e74c68cf554bc1

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
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


cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
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
  r4.y = r5.z + -r4.x;
  r5.x = r0.w * r4.y + r4.x;
  r4.xy = cb11[2].xx * r5.xy;
  r0.w = v3.z * r3.x;
  r4.z = v3.z * r3.x + -1;
  r3.x = r3.x * r4.z + 1;
  r0.w = cb11[2].x * r0.w;
  r4.x = r3.x * r4.x;
  r3.x = -r4.y * r3.x + 1;
  r1.xyz = r4.xxx * r2.xyz + r1.xyz;
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
  r1.w = r1.w ? r2.w : 0;
  if (r1.w != 0) {
    r2.xy = float2(0.375,0.375) * r3.yz;
    r2.zw = cmp(r3.yz < float2(1.06666696,1.73333299));
    r1.w = r2.w ? r2.z : 0;
    r1.w = r1.w ? -1 : 1;
    r1.w = cb2[13].x * r1.w;
    r2.xy = -r1.ww * float2(-4.8599999e-05,-4.8599999e-05) + r2.xy;
    r2.xy = float2(7.69999981,7.69999981) * r2.xy;
    r2.xy = t3.Sample(s3_s, r2.xy).zw;
    r1.w = dot(r2.xy, r2.xy);
    r1.w = min(1, r1.w);
    r2.z = 1 + -r1.w;
    r1.w = dot(r2.xyz, r2.xyz);
    r1.w = sqrt(r1.w);
    r2.xyz = r1.www * r0.yzw;
    r4.xyz = float3(1.097,1.097,1.097) * r2.xyz;
    r5.xy = r3.yz * float2(0.75,0.75) + float2(-1,-1);
    r6.xyz = float3(3.20000005,38.4000015,-76.8000031) * r5.yxy;
    r1.w = cb2[13].x * -0.0106650004;
    r2.w = cb2[13].x * -0.0106650004 + -r6.x;
    r3.y = floor(r6.y);
    r3.y = 12345.5596 * r3.y;
    r3.y = sin(r3.y);
    r3.y = 7658.75977 * r3.y;
    r3.y = frac(r3.y);
    r5.z = r3.y + r2.w;
    r6.xyw = float3(38.4000015,2,2) * r5.xzz;
    r3.yz = floor(r6.xw);
    r2.w = dot(r3.yz, float2(35.2000008,2376.1001));
    r7.xyz = float3(0.103100002,0.113689996,0.137869999) * r2.www;
    r7.xyz = frac(r7.xyz);
    r8.xyz = float3(19.1900005,19.1900005,19.1900005) + r7.yzx;
    r2.w = dot(r7.xyz, r8.xyz);
    r7.xyz = r7.xyz + r2.www;
    r3.yz = r7.xy + r7.yz;
    r3.yz = r3.yz * r7.zx;
    r3.yz = frac(r3.yz);
    r6.xyw = frac(r6.xyw);
    r7.xy = float2(-0.5,-0.5) + r3.yz;
    r2.w = sin(r6.z);
    r3.y = 0.5 + -abs(r7.x);
    r2.w = r3.y * r2.w;
    r2.w = r2.w * r7.y + r7.x;
    r3.y = cb2[13].x * -0.0142200002 + r3.z;
    r3.y = frac(r3.y);
    r3.z = 1.17647099 * r3.y;
    r3.z = min(1, r3.z);
    r4.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r4.w * r3.z;
    r3.y = -1 + r3.y;
    r3.y = -6.66666794 * r3.y;
    r3.y = min(1, r3.y);
    r4.w = r3.y * -2 + 3;
    r3.y = r3.y * r3.y;
    r3.y = r4.w * r3.y;
    r3.y = r3.z * r3.y + -0.5;
    r3.yz = r3.yy * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r6.xyz = float3(-0.5,-0,-1) + r6.xyw;
    r3.z = 1 / r3.z;
    r3.z = saturate(r6.z * r3.z);
    r4.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r4.w * r3.z;
    r3.z = sqrt(r3.z);
    r4.w = r3.y + r3.y;
    r4.w = 1 / r4.w;
    r4.w = r6.y * r4.w;
    r4.w = min(1, r4.w);
    r5.z = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.z * r4.w;
    r4.w = sqrt(r4.w);
    r3.z = r4.w * r3.z;
    r4.w = 0.379999995 * r3.z;
    r5.z = r3.z * r3.z;
    r2.w = -r2.w * 0.699999988 + r6.x;
    r4.w = r5.z * 0.150000006 + -r4.w;
    r2.w = -r3.z * 0.379999995 + abs(r2.w);
    r3.z = 1 / r4.w;
    r2.w = saturate(r3.z * r2.w);
    r3.z = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r3.z * r2.w;
    r3.y = r6.y + -r3.y;
    r3.y = 1 + r3.y;
    r3.y = saturate(0.980392218 * r3.y);
    r3.z = r3.y * -2 + 3;
    r3.y = r3.y * r3.y;
    r3.y = r3.z * r3.y;
    r2.w = r3.y * r2.w;
    r1.w = r5.y * -5.92000008 + r1.w;
    r3.yz = float2(71.0400009,-142.080002) * r5.xy;
    r3.y = floor(r3.y);
    r3.y = 12345.5596 * r3.y;
    r3.y = sin(r3.y);
    r3.y = 7658.75977 * r3.y;
    r3.y = frac(r3.y);
    r5.w = r3.y + r1.w;
    r5.xyz = float3(71.0400009,2,2) * r5.xww;
    r6.xy = floor(r5.xz);
    r1.w = dot(r6.xy, float2(35.2000008,2376.1001));
    r6.xyz = float3(0.103100002,0.113689996,0.137869999) * r1.www;
    r6.xyz = frac(r6.xyz);
    r7.xyz = float3(19.1900005,19.1900005,19.1900005) + r6.yzx;
    r1.w = dot(r6.xyz, r7.xyz);
    r6.xyz = r6.xyz + r1.www;
    r6.yw = r6.xy + r6.yz;
    r6.xy = r6.yw * r6.zx;
    r6.xy = frac(r6.xy);
    r5.xyz = frac(r5.xyz);
    r6.xz = float2(-0.5,-0.5) + r6.xy;
    r1.w = sin(r3.z);
    r3.y = 0.5 + -abs(r6.x);
    r1.w = r3.y * r1.w;
    r1.w = r1.w * r6.z + r6.x;
    r3.y = cb2[13].x * -0.0142200002 + r6.y;
    r3.y = frac(r3.y);
    r3.z = 1.17647099 * r3.y;
    r3.z = min(1, r3.z);
    r4.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r4.w * r3.z;
    r3.y = -1 + r3.y;
    r3.y = -6.66666794 * r3.y;
    r3.y = min(1, r3.y);
    r4.w = r3.y * -2 + 3;
    r3.y = r3.y * r3.y;
    r3.y = r4.w * r3.y;
    r3.y = r3.z * r3.y + -0.5;
    r3.yz = r3.yy * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r5.xyz = float3(-0.5,-0,-1) + r5.xyz;
    r3.z = 1 / r3.z;
    r3.z = saturate(r5.z * r3.z);
    r4.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r4.w * r3.z;
    r3.z = sqrt(r3.z);
    r4.w = r3.y + r3.y;
    r4.w = 1 / r4.w;
    r4.w = r5.y * r4.w;
    r4.w = min(1, r4.w);
    r5.z = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.z * r4.w;
    r4.w = sqrt(r4.w);
    r3.z = r4.w * r3.z;
    r4.w = 0.379999995 * r3.z;
    r5.z = r3.z * r3.z;
    r1.w = -r1.w * 0.699999988 + r5.x;
    r4.w = r5.z * 0.150000006 + -r4.w;
    r1.w = -r3.z * 0.379999995 + abs(r1.w);
    r3.z = 1 / r4.w;
    r1.w = saturate(r3.z * r1.w);
    r3.z = r1.w * -2 + 3;
    r1.w = r1.w * r1.w;
    r1.w = r3.z * r1.w;
    r3.y = r5.y + -r3.y;
    r3.y = 1 + r3.y;
    r3.y = saturate(0.980392218 * r3.y);
    r3.z = r3.y * -2 + 3;
    r3.y = r3.y * r3.y;
    r3.y = r3.z * r3.y;
    r1.w = r3.y * r1.w;
    r1.w = max(r2.w, r1.w);
    r1.w = min(1, r1.w);
    r2.xyz = -r2.xyz * float3(1.097,1.097,1.097) + r0.yzw;
    r2.xyz = r1.www * r2.xyz + r4.xyz;
    r4.xyz = -r2.xyz + r0.yzw;
    r0.yzw = r3.www * r4.xyz + r2.xyz;
  }
  r0.x = saturate(1.53846204 * r0.x);
  r0.x = cb5[3].z * r0.x;
  r1.w = -cb2[13].z + 1;
  r0.x = r1.w * r0.x;
  r2.xy = cb2[12].zy * v3.xx;
  r0.x = r2.x * r0.x;
  r1.w = v3.x * r3.x;
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