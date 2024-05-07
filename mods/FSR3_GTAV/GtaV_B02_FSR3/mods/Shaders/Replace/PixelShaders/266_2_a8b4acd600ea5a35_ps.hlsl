// ---- FNV Hash a8b4acd600ea5a35

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t14 : register(t14);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s0_s : register(s0);

cbuffer cb11 : register(b11)
{
  float4 cb11[7];
}

cbuffer cb12 : register(b12)
{
  float4 cb12[5];
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
  float3 v4 : TEXCOORD3,
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t3.Sample(s3_s, v1.zw).xyzw;
  r1.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  r2.x = dot(v2.xyz, v2.xyz);
  r2.x = rsqrt(r2.x);
  r2.yzw = v2.xyz * r2.xxx;
  r3.xyzw = t5.Sample(s5_s, v1.zw).xyzw;
  r4.x = cmp(5 < cb11[4].x);
  r5.x = 0.00157977897 * v2.w;
  r5.y = cb11[4].y * 633;
  r6.x = v2.w;
  r6.y = cb11[4].y;
  r4.xy = r4.xx ? r5.xy : r6.xy;
  r3.xy = r3.xy * r3.xy;
  r3.x = dot(r3.xyz, cb11[5].xyz);
  r3.yz = r4.yy * r3.xw;
  r4.y = dot(v4.xyz, v4.xyz);
  r4.y = rsqrt(r4.y);
  r5.xyz = v4.xyz * r4.yyy;
  r4.z = cmp(0 < cb11[0].w);
  if (r4.z != 0) {
    r5.x = saturate(dot(r2.yzw, r5.xyz));
    r5.y = 0;
    r5.xyz = t6.Sample(s6_s, r5.xy).xyz;
  } else {
    r5.xyz = cb11[0].xyz;
  }
  r4.z = dot(r5.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r6.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r5.xyyz;
  r6.xyzw = cmp(r5.yxzy < r6.xyzw);
  r4.w = r6.y ? r6.x : 0;
  r4.w = r6.z ? r4.w : 0;
  r4.w = r6.w ? r4.w : 0;
  r5.w = cmp(0.779999971 < r4.z);
  r4.w = r5.w ? r4.w : 0;
  r6.xyz = float3(0.796000004,0.796000004,0.796000004) * r5.xyz;
  r5.xyz = r4.www ? r6.xyz : r5.xyz;
  r5.xyz = r5.xyz * r1.xyz;
  r0.w = cb11[1].w * r0.w;
  r0.xyz = cb11[1].xyz * r0.xyz + -r5.xyz;
  r1.xyz = r0.www * r0.xyz + r5.xyz;
  r0.xyzw = v3.xxxw * r1.xyzw;
  r1.xy = cb2[12].zy * v3.xx;
  r1.z = saturate(cb3[49].w + cb2[13].z);
  r5.y = r1.y * r1.z;
  r1.y = v3.x * r3.y;
  r1.y = r4.x * r1.y;
  r1.zw = -cb11[2].zz + float2(1,2);
  r3.y = v3.z * r1.z;
  r6.xyz = v1.xyy * r1.www;
  r7.xyz = t4.Sample(s4_s, r6.xz).xyz;
  r1.w = t4.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r4.x = cmp(0.49000001 < r1.w);
  r1.w = cmp(r1.w < 0.50999999);
  r1.w = r1.w ? r4.x : 0;
  r4.x = saturate(cb11[2].y * 2.5 + -1.5);
  r4.w = r7.x * r4.x;
  r8.y = 1.29999995 * r4.w;
  r8.z = r7.y;
  r8.yz = r1.ww ? r8.yz : r7.yz;
  r4.w = t4.Sample(s4_s, r6.xz, int2(0, 0)).x;
  r5.z = t4.Sample(s4_s, r6.xz, int2(0, 0)).x;
  r5.w = t4.Sample(s4_s, r6.xz, int2(0, 0)).x;
  r6.w = t4.Sample(s4_s, r6.xz, int2(0, 0)).x;
  r4.w = 0.333333313 * r4.w;
  r5.zw = float2(0.333333313,0.333333313) * r5.zw;
  r6.w = 0.333333313 * r6.w;
  r4.z = -0.0170000009 + r4.z;
  r7.y = dot(cb11[3].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r4.z = cmp(r4.z < r7.y);
  r4.w = r4.z ? r4.w : -r4.w;
  r5.zw = r4.zz ? r5.zw : -r5.zw;
  r4.z = r4.z ? r6.w : -r6.w;
  r4.z = r4.z + -r5.w;
  r9.x = r4.z + r4.z;
  r4.z = r5.z + -r4.w;
  r9.y = r4.z + r4.z;
  r4.z = -r9.x * r9.x + 1;
  r4.z = -r9.y * r9.y + r4.z;
  r9.z = sqrt(r4.z);
  r7.yzw = max(float3(-1,-1,-1), r9.xyz);
  r7.yzw = min(float3(1,1,1), r7.yzw);
  r9.xyz = -cb3[0].xyz + float3(0,0,-1);
  r9.xyz = cb11[6].www * r9.xyz + cb3[0].xyz;
  r4.yzw = v4.xyz * r4.yyy + -r9.xyz;
  r5.z = dot(r4.yzw, r4.yzw);
  r5.z = rsqrt(r5.z);
  r10.xyz = r5.zzz * r4.yzw;
  r4.yzw = -r4.yzw * r5.zzz + float3(1,1,1);
  r4.yzw = sqrt(r4.yzw);
  r4.y = dot(r7.yzw, r4.yzw);
  r4.z = r7.x * r4.y;
  r4.w = cb11[2].z * cb5[3].z;
  r4.y = -r7.x * r4.y + r8.z;
  r8.x = r4.w * r4.y + r4.z;
  r4.yz = cb11[2].xx * r8.xy;
  r4.w = v3.z * r1.z + -1;
  r1.z = r1.z * r4.w + 1;
  r4.y = r4.y * r1.z;
  r7.xyz = cb11[3].xyz * cb11[2].yyy;
  r7.xyz = r7.xyz * float3(1.07558298,0.994183481,0.930233717) + -r0.xyz;
  r0.xyz = r4.yyy * r7.xyz + r0.xyz;
  r3.y = cb11[2].x * r3.y;
  r7.xyz = r8.zzz + -r0.xyz;
  r0.xyz = r3.yyy * r7.xyz + r0.xyz;
  r1.z = -r4.z * r1.z + 1;
  r7.x = r1.y * r1.z;
  r3.y = cb11[2].w * v3.x;
  r3.x = r3.y * r3.x;
  r3.x = 0.75 * r3.x;
  r3.y = cmp(1.5 < abs(cb11[0].w));
  if (r3.y != 0) {
    r8.x = saturate(dot(r2.yzw, -r9.xyz));
    r8.y = 0;
    r4.yzw = t14.Sample(s14_s, r8.xy).xyz;
  } else {
    r4.yzw = cb11[6].xyz;
  }
  r4.yzw = r4.yzw * r3.xxx;
  r3.x = dot(r2.yzw, r10.xyz);
  r3.x = saturate(9.99999994e-09 + r3.x);
  r3.y = r3.w * 15 + 9.99999994e-09;
  r3.x = log2(r3.x);
  r3.x = r3.y * r3.x;
  r3.x = exp2(r3.x);
  r0.xyz = r4.yzw * r3.xxx + r0.xyz;
  r0.xyz = min(float3(240,240,240), r0.xyz);
  r8.w = cb2[12].x * r0.w;
  r2.yzw = r2.yzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.w = cmp(cb11[2].y < 1);
  r0.w = r0.w ? r1.w : 0;
  if (r0.w != 0) {
    r3.xy = cmp(r6.xz < float2(0.400000006,0.649999976));
    r0.w = r3.y ? r3.x : 0;
    r1.w = r0.w ? -1 : 1;
    r1.w = cb2[13].x * r1.w;
    r3.xy = -r1.ww * float2(4.8599999e-05,4.8599999e-05) + r6.xz;
    r3.xy = float2(7.69999981,7.69999981) * r3.xy;
    r3.xy = t4.Sample(s4_s, r3.xy).zw;
    r1.w = dot(r3.xy, r3.xy);
    r1.w = min(1, r1.w);
    r3.w = 1 + -r1.w;
    r1.w = dot(r3.xyw, r3.xyw);
    r1.w = sqrt(r1.w);
    r3.xyw = r2.yzw * r1.www;
    r4.yzw = float3(1.097,1.097,1.097) * r3.xyw;
    r6.xyz = r6.xyz * float3(2,2,2) + float3(-1,-1,-1);
    r6.xyz = float3(3.20000005,3.20000005,-2.4000001) * r6.xyz;
    r6.w = -r6.y;
    r6.xy = r0.ww ? r6.zz : r6.xw;
    r1.w = cb2[13].x * 0.0109350001;
    r5.z = cb2[13].x * 0.0109350001 + r6.y;
    r9.xyz = float3(12,24,22.2000008) * r6.xyx;
    r9.xz = floor(r9.xz);
    r9.xz = float2(12345.5596,12345.5596) * r9.xz;
    r9.xz = sin(r9.xz);
    r9.xz = float2(7658.75977,7658.75977) * r9.xz;
    r9.xz = frac(r9.xz);
    r6.z = r9.x + r5.z;
    r10.xyzw = float4(12,2,2,44.4000015) * r6.xzzy;
    r5.zw = floor(r10.xz);
    r5.z = dot(r5.zw, float2(35.2000008,2376.1001));
    r11.xyz = float3(0.103100002,0.113689996,0.137869999) * r5.zzz;
    r11.xyz = frac(r11.xyz);
    r12.xyz = float3(19.1900005,19.1900005,19.1900005) + r11.yzx;
    r5.z = dot(r11.xyz, r12.xyz);
    r11.xyz = r11.xyz + r5.zzz;
    r5.zw = r11.xy + r11.yz;
    r5.zw = r5.zw * r11.zx;
    r5.zw = frac(r5.zw);
    r10.xyz = frac(r10.xyz);
    r9.xw = float2(-0.5,-0.5) + r5.zw;
    r5.z = sin(r9.y);
    r6.z = 0.5 + -abs(r9.x);
    r5.z = r6.z * r5.z;
    r5.z = r5.z * r9.w + r9.x;
    r5.w = cb2[13].x * 0.0145800002 + r5.w;
    r5.w = frac(r5.w);
    r6.z = 1.17647099 * r5.w;
    r6.z = min(1, r6.z);
    r7.w = r6.z * -2 + 3;
    r6.z = r6.z * r6.z;
    r6.z = r7.w * r6.z;
    r5.w = -1 + r5.w;
    r5.w = -6.66666794 * r5.w;
    r5.w = min(1, r5.w);
    r7.w = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r7.w * r5.w;
    r5.w = r6.z * r5.w + -0.5;
    r9.xy = r5.ww * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r10.xyz = float3(-0.5,-0,-1) + r10.xyz;
    r5.w = 1 / r9.y;
    r5.w = saturate(r10.z * r5.w);
    r6.z = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r6.z * r5.w;
    r5.w = sqrt(r5.w);
    r6.z = r9.x + r9.x;
    r6.z = 1 / r6.z;
    r6.z = r10.y * r6.z;
    r6.z = min(1, r6.z);
    r7.w = r6.z * -2 + 3;
    r6.z = r6.z * r6.z;
    r6.z = r7.w * r6.z;
    r6.z = sqrt(r6.z);
    r5.w = r6.z * r5.w;
    r6.z = 0.379999995 * r5.w;
    r7.w = r5.w * r5.w;
    r5.z = -r5.z * 0.699999988 + r10.x;
    r6.z = r7.w * 0.150000006 + -r6.z;
    r5.z = -r5.w * 0.379999995 + abs(r5.z);
    r5.w = 1 / r6.z;
    r5.z = saturate(r5.z * r5.w);
    r5.w = r5.z * -2 + 3;
    r5.z = r5.z * r5.z;
    r5.z = r5.w * r5.z;
    r5.w = r10.y + -r9.x;
    r5.w = 1 + r5.w;
    r5.w = saturate(0.980392218 * r5.w);
    r6.z = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r6.z * r5.w;
    r5.z = r5.z * r5.w;
    r1.w = r6.y * 1.85000002 + r1.w;
    r6.w = r1.w + r9.z;
    r6.xyz = float3(22.2000008,2,2) * r6.xww;
    r9.xy = floor(r6.xz);
    r1.w = dot(r9.xy, float2(35.2000008,2376.1001));
    r9.xyz = float3(0.103100002,0.113689996,0.137869999) * r1.www;
    r9.xyz = frac(r9.xyz);
    r10.xyz = float3(19.1900005,19.1900005,19.1900005) + r9.yzx;
    r1.w = dot(r9.xyz, r10.xyz);
    r9.xyz = r9.xyz + r1.www;
    r9.yw = r9.xy + r9.yz;
    r9.xy = r9.yw * r9.zx;
    r9.xy = frac(r9.xy);
    r6.xyz = frac(r6.xyz);
    r9.xz = float2(-0.5,-0.5) + r9.xy;
    r1.w = sin(r10.w);
    r5.w = 0.5 + -abs(r9.x);
    r1.w = r5.w * r1.w;
    r1.w = r1.w * r9.z + r9.x;
    r5.w = cb2[13].x * 0.0145800002 + r9.y;
    r5.w = frac(r5.w);
    r6.w = 1.17647099 * r5.w;
    r6.w = min(1, r6.w);
    r7.w = r6.w * -2 + 3;
    r6.w = r6.w * r6.w;
    r6.w = r7.w * r6.w;
    r5.w = -1 + r5.w;
    r5.w = -6.66666794 * r5.w;
    r5.w = min(1, r5.w);
    r7.w = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r7.w * r5.w;
    r5.w = r6.w * r5.w + -0.5;
    r9.xy = r5.ww * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r6.xyz = float3(-0.5,-0,-1) + r6.xyz;
    r5.w = 1 / r9.y;
    r5.w = saturate(r6.z * r5.w);
    r6.z = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r6.z * r5.w;
    r5.w = sqrt(r5.w);
    r6.z = r9.x + r9.x;
    r6.z = 1 / r6.z;
    r6.z = r6.y * r6.z;
    r6.z = min(1, r6.z);
    r6.w = r6.z * -2 + 3;
    r6.z = r6.z * r6.z;
    r6.z = r6.w * r6.z;
    r6.z = sqrt(r6.z);
    r5.w = r6.z * r5.w;
    r6.z = 0.379999995 * r5.w;
    r6.w = r5.w * r5.w;
    r1.w = -r1.w * 0.699999988 + r6.x;
    r6.x = r6.w * 0.150000006 + -r6.z;
    r1.w = -r5.w * 0.379999995 + abs(r1.w);
    r5.w = 1 / r6.x;
    r1.w = saturate(r5.w * r1.w);
    r5.w = r1.w * -2 + 3;
    r1.w = r1.w * r1.w;
    r1.w = r5.w * r1.w;
    r5.w = r6.y + -r9.x;
    r5.w = 1 + r5.w;
    r5.w = saturate(0.980392218 * r5.w);
    r6.x = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r6.x * r5.w;
    r1.w = r5.w * r1.w;
    r1.w = max(r5.z, r1.w);
    r1.w = min(1, r1.w);
    r3.xyw = -r3.xyw * float3(1.097,1.097,1.097) + r2.yzw;
    r3.xyw = r1.www * r3.xyw + r4.yzw;
    r0.w = r0.w ? 0.003900 : 0;
    r0.w = r1.w * r0.w + 1;
    r4.yzw = -r3.xyw + r2.yzw;
    r2.yzw = r4.xxx * r4.yzw + r3.xyw;
  } else {
    r0.w = 1;
  }
  r3.xyw = float3(256,256,256) * r2.zyw;
  r3.xyw = floor(r3.yxw);
  r2.yzw = r2.zyw * float3(256,256,256) + -r3.yxw;
  r2.yzw = float3(8,8,4) * r2.yzw;
  r2.yzw = floor(r2.yzw);
  r1.w = dot(r2.yzw, float3(4,32,1));
  o1.w = 0.00392156886 * r1.w;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r3.xyw;
  r7.y = 0.001953125 * r3.z;
  r5.x = cb2[12].z * v3.x + cb3[45].w;
  r2.yz = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r2.yz);
  r1.w = v2.z * r2.x + -0.349999994;
  r1.w = saturate(1.53846204 * r1.w);
  r1.w = cb5[3].z * r1.w;
  r2.x = -cb2[13].z + 1;
  r1.w = r2.x * r1.w;
  r1.x = r1.w * r1.x;
  r1.w = r7.x * -0.5 + 1;
  r1.w = r1.w * r1.x;
  r1.w = r1.w * -0.5 + 1;
  r8.xyz = r1.www * r0.xyz;
  r0.x = saturate(r1.y * r1.z + 0.400000006);
  r7.z = cb11[3].w * r0.w;
  r0.xy = r0.xx * float2(0.5,0.48828131) + -r7.xy;
  r0.xy = max(float2(0,0), r0.xy);
  r0.z = 0;
  r0.xyz = r0.xyz * r1.xxx + r7.xyz;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r8.xyzw;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}