// ---- FNV Hash 7851772294b2de6e

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:29:54 2023
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
  float4 cb11[9];
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

  r0.xy = cb11[0].xx * v1.xy;
  r0.zw = cb11[6].ww * v1.xy;
  r1.xyzw = t3.Sample(s3_s, v1.zw).xyzw;
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.x = dot(v2.xyz, v2.xyz);
  r3.x = rsqrt(r0.x);
  r4.xyz = v2.xyz * r3.xxx;
  r0.xyzw = t5.Sample(s5_s, r0.zw).xyzw;
  r0.xy = r0.xy * r0.xy;
  r3.y = dot(r0.xyz, cb11[6].xyz);
  r0.x = cb11[5].y * r3.y;
  r0.y = cb11[5].x * r0.w;
  r0.z = dot(v4.xyz, v4.xyz);
  r0.z = rsqrt(r0.z);
  r5.xyz = v4.xyz * r0.zzz;
  r3.w = cmp(0 < cb11[1].x);
  if (r3.w != 0) {
    r5.x = saturate(dot(r4.xyz, r5.xyz));
    r5.y = 0;
    r5.xyz = t6.Sample(s6_s, r5.xy).xyz;
  } else {
    r5.xyz = cb11[0].yzw;
  }
  r3.w = dot(r5.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r6.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r5.xyyz;
  r6.xyzw = cmp(r5.yxzy < r6.xyzw);
  r4.w = r6.y ? r6.x : 0;
  r4.w = r6.z ? r4.w : 0;
  r4.w = r6.w ? r4.w : 0;
  r5.w = cmp(0.779999971 < r3.w);
  r4.w = r5.w ? r4.w : 0;
  r6.xyz = float3(0.796000004,0.796000004,0.796000004) * r5.xyz;
  r5.xyz = r4.www ? r6.xyz : r5.xyz;
  r5.xyz = r5.xyz * r2.xyz;
  r1.w = cb11[2].w * r1.w;
  r1.xyz = cb11[2].xyz * r1.xyz + -r5.xyz;
  r2.xyz = r1.www * r1.xyz + r5.xyz;
  r1.xyzw = v3.xxxw * r2.xyzw;
  r2.xy = cb2[12].zy * v3.xx;
  r2.z = saturate(cb3[49].w + cb2[13].z);
  r5.y = r2.y * r2.z;
  r0.x = v3.x * r0.x;
  r3.z = v2.w * r0.x;
  r2.yz = -cb11[3].zz + float2(1,2);
  r0.x = v3.z * r2.y;
  r2.zw = v1.xy * r2.zz;
  r4.w = cmp(160.000000 == cb11[5].x);
  if (r4.w != 0) {
    r4.w = cb2[4].x * 4;
    r4.w = cb2[13].x * 0.00400000019 + r4.w;
    r5.z = 0.100000001 * r4.w;
    r6.xyzw = v2.xyxy * float4(2,2,2,2) + r5.zzzz;
    r7.xy = floor(r6.zw);
    r7.zw = float2(1,1) + r7.xy;
    r6.xyzw = -r7.xyzw + r6.xyzw;
    r7.xyzw = float4(0.105999999,5.57399988,0.105999999,5.57399988) * r7.xyzw;
    r7.xyzw = frac(r7.xyzw);
    r8.xyzw = float4(3.99399996,7.72800016,3.99399996,7.72800016) + r7.xyzw;
    r9.xyzw = r8.xxzz * r7.ywyw;
    r8.xyzw = r7.xxzz * r8.ywyw + r9.xyzw;
    r9.xyzw = r8.xyzw + r7.xxzz;
    r7.xyzw = r8.xyzw + r7.ywyw;
    r7.xyzw = r9.xyzw * r7.xyzw;
    r7.xyzw = frac(r7.xyzw);
    r4.w = 6 + r4.w;
    r7.xyzw = r7.xyzw * r4.wwww;
    sincos(r7.xyzw, r7.xyzw, r8.xyzw);
    r7.xyzw = r7.xyzw * r6.ywyw;
    r7.xyzw = r8.xyzw * r6.xxzz + r7.xyzw;
    r6.zw = -r6.xy * float2(2,2) + float2(3,3);
    r6.xy = r6.xy * r6.xy;
    r6.xy = r6.zw * r6.xy;
    r6.zw = r7.zw + -r7.xy;
    r6.xz = r6.xx * r6.zw + r7.xy;
    r5.w = r6.z + -r6.x;
    r6.x = r6.y * r5.w + r6.x;
    r7.xyzw = v2.xyxy * float4(6,6,3,3) + r5.zzzz;
    r7.xyzw = float4(8,8,4,4) + r7.xyzw;
    r8.xyzw = floor(r7.xyzw);
    r9.xyzw = float4(0,0,1,1) + r8.xyxy;
    r10.xyzw = -r9.xyzw + r7.xyxy;
    r9.xyzw = float4(0.105999999,5.57399988,0.105999999,5.57399988) * r9.xyzw;
    r9.xyzw = frac(r9.xyzw);
    r11.xyzw = float4(3.99399996,7.72800016,3.99399996,7.72800016) + r9.xyzw;
    r12.xyzw = r11.xxzz * r9.ywyw;
    r11.xyzw = r9.xxzz * r11.ywyw + r12.xyzw;
    r12.xyzw = r11.xyzw + r9.xxzz;
    r9.xyzw = r11.xyzw + r9.ywyw;
    r9.xyzw = r12.xyzw * r9.xyzw;
    r9.xyzw = frac(r9.xyzw);
    r9.xyzw = r9.xyzw * r4.wwww;
    sincos(r9.xyzw, r9.xyzw, r11.xyzw);
    r9.xyzw = r9.xyzw * r10.ywyw;
    r9.xyzw = r11.xyzw * r10.xxzz + r9.xyzw;
    r5.zw = -r10.xy * float2(2,2) + float2(3,3);
    r7.xy = r10.xy * r10.xy;
    r5.zw = r7.xy * r5.zw;
    r7.xy = r9.zw + -r9.xy;
    r7.xy = r5.zz * r7.xy + r9.xy;
    r5.z = r7.y + -r7.x;
    r6.y = r5.w * r5.z + r7.x;
    r8.xyzw = float4(0,0,1,1) + r8.zwzw;
    r7.xyzw = -r8.xyzw + r7.zwzw;
    r8.xyzw = float4(0.105999999,5.57399988,0.105999999,5.57399988) * r8.xyzw;
    r8.xyzw = frac(r8.xyzw);
    r9.xyzw = float4(3.99399996,7.72800016,3.99399996,7.72800016) + r8.xyzw;
    r10.xyzw = r9.xxzz * r8.ywyw;
    r9.xyzw = r8.xxzz * r9.ywyw + r10.xyzw;
    r10.xyzw = r9.xyzw + r8.xxzz;
    r8.xyzw = r9.xyzw + r8.ywyw;
    r8.xyzw = r10.xyzw * r8.xyzw;
    r8.xyzw = frac(r8.xyzw);
    r8.xyzw = r8.xyzw * r4.wwww;
    sincos(r8.xyzw, r8.xyzw, r9.xyzw);
    r8.xyzw = r8.xyzw * r7.ywyw;
    r8.xyzw = r9.xyzw * r7.xxzz + r8.xyzw;
    r5.zw = -r7.xy * float2(2,2) + float2(3,3);
    r7.xy = r7.xy * r7.xy;
    r5.zw = r7.xy * r5.zw;
    r7.xy = r8.zw + -r8.xy;
    r7.xy = r5.zz * r7.xy + r8.xy;
    r4.w = r7.y + -r7.x;
    r6.z = r5.w * r4.w + r7.x;
    r4.w = 26 * r6.x;
    r6.xyz = r6.xyz * float3(0.600000024,0.600000024,0.600000024) + float3(0.600000024,0.600000024,0.600000024);
    sincos(r4.w, r7.x, r8.x);
    r7.x = 0.577400029 * r7.x;
    r4.w = 1 + -r8.x;
    r7.z = r8.x;
    r7.y = -r7.x;
    r7.xyz = r4.www * float3(0.333333313,0.333333313,0.333333313) + r7.xyz;
    r8.x = dot(r6.yzx, r7.xyz);
    r8.y = dot(r6.zxy, r7.xyz);
    r8.z = dot(r6.xyz, r7.xyz);
    r6.xyz = float3(-0.5,-0.5,-0.5) + r8.xyz;
    r7.xyz = -cb3[0].xyz + float3(0,0,-1);
    r7.xyz = cb11[8].www * r7.xyz + cb3[0].xyz;
    r7.xyz = v4.xyz * r0.zzz + -r7.xyz;
    r4.w = dot(r7.xyz, r7.xyz);
    r4.w = rsqrt(r4.w);
    r7.xyz = r7.xyz * r4.www;
    r4.w = dot(r4.xyz, r7.xyz);
    r4.w = saturate(9.99999994e-09 + r4.w);
    r4.w = log2(r4.w);
    r4.w = 15 * r4.w;
    r4.w = exp2(r4.w);
    r3.xyz = r6.xyz * r4.www + r3.xyz;
  }
  r6.xyz = t4.Sample(s4_s, r2.zw).xyz;
  r4.w = t4.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r5.z = cmp(0.49000001 < r4.w);
  r4.w = cmp(r4.w < 0.50999999);
  r4.w = r4.w ? r5.z : 0;
  r7.x = cb11[3].x * 110;
  r5.z = saturate(cb11[3].y * 2.5 + -1.5);
  r5.w = r6.x * r5.z;
  r7.y = 1.29999995 * r5.w;
  r7.z = r6.y;
  r8.yz = r4.ww ? r7.yz : r6.yz;
  r4.w = t4.Sample(s4_s, r2.zw, int2(0, 0)).x;
  r5.w = t4.Sample(s4_s, r2.zw, int2(0, 0)).x;
  r6.y = t4.Sample(s4_s, r2.zw, int2(0, 0)).x;
  r6.z = t4.Sample(s4_s, r2.zw, int2(0, 0)).x;
  r4.w = 0.333333313 * r4.w;
  r5.w = 0.333333313 * r5.w;
  r6.yz = float2(0.333333313,0.333333313) * r6.yz;
  r3.w = -0.0170000009 + r3.w;
  r6.w = dot(cb11[4].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r3.w = cmp(r3.w < r6.w);
  r4.w = r3.w ? r4.w : -r4.w;
  r5.w = r3.w ? r5.w : -r5.w;
  r6.y = r3.w ? r6.y : -r6.y;
  r3.w = r3.w ? r6.z : -r6.z;
  r3.w = r3.w + -r6.y;
  r9.x = r3.w + r3.w;
  r3.w = r5.w + -r4.w;
  r9.y = r3.w + r3.w;
  r3.w = -r9.x * r9.x + 1;
  r3.w = -r9.y * r9.y + r3.w;
  r9.z = sqrt(r3.w);
  r6.yzw = max(float3(-1,-1,-1), r9.xyz);
  r6.yzw = min(float3(1,1,1), r6.yzw);
  r7.yzw = -cb3[0].xyz + float3(0,0,-1);
  r7.yzw = cb11[8].www * r7.yzw + cb3[0].xyz;
  r9.xyz = v4.xyz * r0.zzz + -r7.yzw;
  r3.w = dot(r9.xyz, r9.xyz);
  r3.w = rsqrt(r3.w);
  r10.xyz = r9.xyz * r3.www;
  r9.xyz = -r9.xyz * r3.www + float3(1,1,1);
  r9.xyz = sqrt(r9.xyz);
  r3.w = dot(r6.yzw, r9.xyz);
  r4.w = r6.x * r3.w;
  r5.w = cb11[3].z * cb5[3].z;
  r3.w = -r6.x * r3.w + r8.z;
  r8.x = r5.w * r3.w + r4.w;
  r6.yz = cb11[3].xx * r8.xy;
  r3.w = v3.z * r2.y + -1;
  r2.y = r2.y * r3.w + 1;
  r3.w = r6.y * r2.y;
  r8.xyw = cb11[4].xyz * cb11[3].yyy;
  r8.xyw = r8.xyw * float3(1.07558298,0.994183481,0.930233717) + -r1.xyz;
  r6.yw = cb2[13].ww + float2(-1.25,-1.35000002);
  r4.w = r6.y * r6.w;
  r4.w = saturate(-400 * r4.w);
  r5.w = cmp(0 < r4.w);
  r6.y = log2(r6.x);
  r6.y = 20 * r6.y;
  r6.y = exp2(r6.y);
  r7.x = saturate(r7.x);
  r6.y = r7.x * r6.y;
  r4.w = r6.y * r4.w;
  r6.y = r6.x * r4.w;
  r4.w = -r6.x * r4.w + 1;
  r6.xyw = r1.xyz * r4.www + r6.yyy;
  r1.xyz = r5.www ? r6.xyw : r1.xyz;
  r1.xyz = r3.www * r8.xyw + r1.xyz;
  r0.x = cb11[3].x * r0.x;
  r6.xyw = r8.zzz + -r1.xyz;
  r1.xyz = r0.xxx * r6.xyw + r1.xyz;
  r0.x = -r6.z * r2.y + 1;
  r6.x = r0.x * r3.z;
  r2.y = cmp(0 < cb11[7].y);
  if (r2.y != 0) {
    r2.y = cb11[7].y * cb11[3].w;
    r2.y = v3.x * r2.y;
    r2.y = r2.y * r3.y;
    r3.y = cmp(1.5 < abs(cb11[1].x));
    if (r3.y != 0) {
      r7.x = saturate(dot(r4.xyz, -r7.yzw));
      r7.y = 0;
      r7.xyz = t14.Sample(s14_s, r7.xy).xyz;
    } else {
      r7.xyz = cb11[8].xyz;
    }
    r7.xyz = r7.xyz * r2.yyy;
    r2.y = dot(r4.xyz, r10.xyz);
    r2.y = saturate(9.99999994e-09 + r2.y);
    r0.w = cb11[7].x * r0.w + 9.99999994e-09;
    r2.y = log2(r2.y);
    r0.w = r2.y * r0.w;
    r0.w = exp2(r0.w);
    r1.xyz = r7.xyz * r0.www + r1.xyz;
  }
  r1.xyz = min(float3(240,240,240), r1.xyz);
  r7.w = cb2[12].x * r1.w;
  r4.xyz = r4.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.w = cmp(cb11[3].y < 1);
  if (r0.w != 0) {
    r3.yw = cmp(r2.zw < float2(0.409999996,0.660000026));
    r0.w = r3.w ? r3.y : 0;
    r2.yz = r2.zw * float2(2,2) + float2(-1,-1);
    r8.xy = float2(4.0999999,4.0999999) * r2.yz;
    r8.z = -r8.y;
    r9.x = dot(r8.xz, float2(-4.37113883e-08,-1));
    r9.y = dot(r8.xz, float2(1,-4.37113883e-08));
    r9.xyzw = float4(0.699999988,0.699999988,0.699999988,0.699999988) * r9.xyyx;
    r8.xyzw = r0.wwww ? r9.xyzw : r8.xzzx;
    r2.yz = float2(1,1.5) + -r5.zz;
    r0.w = 0.666666687 * r2.z;
    r1.w = r2.z * -1.33333302 + 3;
    r0.w = r0.w * r0.w;
    r0.w = dot(r1.ww, r0.ww);
    r1.w = r2.y + r2.y;
    r1.w = min(1, r1.w);
    r2.y = r1.w * -2 + 3;
    r1.w = r1.w * r1.w;
    r1.w = r2.y * r1.w;
    r8.xyzw = float4(0.00100000005,0,0.00100000005,0) + r8.xyzw;
    r2.yzw = float3(22.2000008,37,18.5) * r8.xyy;
    r3.y = cb2[13].x * 0.00374999992;
    r3.w = r8.y * 1.85000002 + r3.y;
    r2.y = floor(r2.y);
    r2.y = 12345.5596 * r2.y;
    r2.yz = sin(r2.yz);
    r2.y = 7658.75977 * r2.y;
    r2.y = frac(r2.y);
    r9.y = r3.w + r2.y;
    r9.xz = r8.xw;
    r5.zw = float2(22.2000008,2) * r9.xy;
    r6.zw = floor(r5.zw);
    r2.y = dot(r6.zw, float2(35.2000008,2376.1001));
    r10.xyz = float3(0.103100002,0.113689996,0.137869999) * r2.yyy;
    r10.xyz = frac(r10.xyz);
    r11.xyz = float3(19.1900005,19.1900005,19.1900005) + r10.yzx;
    r2.y = dot(r10.xyz, r11.xyz);
    r10.xyz = r10.xyz + r2.yyy;
    r6.zw = r10.xy + r10.yz;
    r6.zw = r6.zw * r10.zx;
    r6.zw = frac(r6.zw);
    r10.xy = frac(r5.zw);
    r2.y = -1 + r10.y;
    r5.zw = float2(-0.5,-0.5) + r6.zw;
    r2.z = r8.y * 37 + r2.z;
    r2.z = sin(r2.z);
    r3.w = 0.5 + -abs(r5.z);
    r2.z = r3.w * r2.z;
    r2.z = r2.z * r5.w + r5.z;
    r11.x = 0.699999988 * r2.z;
    r2.z = cb2[13].x * 0.00499999989 + r6.w;
    r2.z = frac(r2.z);
    r3.w = 1.17647099 * r2.z;
    r3.w = min(1, r3.w);
    r4.w = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.w * r3.w;
    r2.z = -1 + r2.z;
    r2.z = -6.66666794 * r2.z;
    r2.z = min(1, r2.z);
    r4.w = r2.z * -2 + 3;
    r2.z = r2.z * r2.z;
    r2.z = r4.w * r2.z;
    r2.z = r3.w * r2.z + -0.5;
    r11.yz = r2.zz * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r10.zw = float2(-0.5,-0.5) + r10.xx;
    r5.zw = -r11.xy + r10.zy;
    r6.zw = float2(1,6) * r5.zw;
    r2.z = dot(r6.zw, r6.zw);
    r2.z = sqrt(r2.z);
    r2.z = -0.400000006 + r2.z;
    r2.z = -2.5 * r2.z;
    r2.z = max(0, r2.z);
    r3.w = r2.z * -2 + 3;
    r4.w = 1 / r11.z;
    r2.y = saturate(r4.w * r2.y);
    r4.w = r2.y * -2 + 3;
    r2.y = r2.y * r2.y;
    r2.y = r4.w * r2.y;
    r4.w = sqrt(r2.y);
    r6.z = 0.200000003 * r4.w;
    r5.z = -r4.w * 0.200000003 + abs(r5.z);
    r6.z = 1 / -r6.z;
    r5.z = saturate(r6.z * r5.z);
    r6.z = r5.z * -2 + 3;
    r5.z = r5.z * r5.z;
    r5.z = r6.z * r5.z;
    r5.w = 0.0199999996 + r5.w;
    r5.w = saturate(25 * r5.w);
    r6.z = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r6.z * r5.w;
    r2.y = r5.w * r2.y;
    r12.x = r5.z * r2.y;
    r2.y = frac(r2.w);
    r2.y = r10.y + r2.y;
    r11.w = -0.5 + r2.y;
    r2.yw = -r11.xw + r10.wy;
    r2.y = dot(r2.yw, r2.yw);
    r2.y = sqrt(r2.y);
    r2.y = -0.300000012 + r2.y;
    r2.y = -3.33333302 * r2.y;
    r2.y = max(0, r2.y);
    r2.w = r2.y * -2 + 3;
    r2.yz = r2.yz * r2.yz;
    r2.y = r2.w * r2.y;
    r2.y = r2.y * r4.w;
    r2.y = r2.y * r5.w;
    r2.y = r3.w * r2.z + r2.y;
    r10.xyz = float3(30,30,22.2000008) * r8.xyw;
    r11.xyz = floor(r10.xyz);
    r2.zw = frac(r10.xy);
    r2.zw = float2(-0.5,-0.5) + r2.zw;
    r3.w = dot(r11.xy, float2(107.449997,3543.65405));
    r10.xyz = float3(0.137869999,0.113689996,0.103100002) * r3.www;
    r10.xyz = frac(r10.xyz);
    r11.xyw = float3(19.1900005,19.1900005,19.1900005) + r10.yxz;
    r3.w = dot(r10.zyx, r11.xyw);
    r10.xyz = r10.xyz + r3.www;
    r11.xyw = r10.zzy + r10.yxx;
    r10.xyz = r11.xyw * r10.xyz;
    r10.xyz = frac(r10.xyz);
    r5.zw = float2(-0.5,-0.5) + r10.xy;
    r2.zw = -r5.zw * float2(0.699999988,0.699999988) + r2.zw;
    r2.z = dot(r2.zw, r2.zw);
    r2.z = sqrt(r2.z);
    r2.z = -0.300000012 + r2.z;
    r2.z = -3.33333302 * r2.z;
    r2.z = max(0, r2.z);
    r2.w = r2.z * -2 + 3;
    r2.z = r2.z * r2.z;
    r2.z = r2.w * r2.z;
    r2.w = 10 * r10.z;
    r2.w = frac(r2.w);
    r2.z = r2.z * r2.w;
    r2.w = cb2[13].x * 0.00499999989 + r10.z;
    r2.w = frac(r2.w);
    r3.w = 40 * r2.w;
    r3.w = min(1, r3.w);
    r4.w = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.w * r3.w;
    r2.w = -1 + r2.w;
    r2.w = -1.02564096 * r2.w;
    r2.w = min(1, r2.w);
    r4.w = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r4.w * r2.w;
    r2.w = r3.w * r2.w;
    r2.z = r2.z * r2.w;
    r2.y = r2.y * r1.w;
    r2.y = r2.z * r0.w + r2.y;
    r2.y = -0.300000012 + r2.y;
    r2.y = saturate(0.588235319 * r2.y);
    r2.z = r2.y * -2 + 3;
    r2.y = r2.y * r2.y;
    r2.w = r2.z * r2.y;
    r3.y = r8.z * 1.85000002 + r3.y;
    r3.w = 12345.5596 * r11.z;
    r3.w = sin(r3.w);
    r3.w = 7658.75977 * r3.w;
    r3.w = frac(r3.w);
    r9.w = r3.y + r3.w;
    r3.yw = float2(22.2000008,2) * r9.zw;
    r5.zw = floor(r3.yw);
    r4.w = dot(r5.zw, float2(35.2000008,2376.1001));
    r9.xyz = float3(0.103100002,0.113689996,0.137869999) * r4.www;
    r9.xyz = frac(r9.xyz);
    r10.xyz = float3(19.1900005,19.1900005,19.1900005) + r9.yzx;
    r4.w = dot(r9.xyz, r10.xyz);
    r9.xyz = r9.xyz + r4.www;
    r5.zw = r9.xy + r9.yz;
    r5.zw = r5.zw * r9.zx;
    r5.zw = frac(r5.zw);
    r9.xy = frac(r3.yw);
    r3.y = -1 + r9.y;
    r6.zw = float2(-0.5,-0.5) + r5.zw;
    r10.xyzw = float4(37,18.5,30,30) * r8.zzwz;
    r3.w = sin(r10.x);
    r3.w = r8.z * 37 + r3.w;
    r3.w = sin(r3.w);
    r4.w = 0.5 + -abs(r6.z);
    r3.w = r4.w * r3.w;
    r3.w = r3.w * r6.w + r6.z;
    r8.x = 0.699999988 * r3.w;
    r3.w = cb2[13].x * 0.00499999989 + r5.w;
    r3.w = frac(r3.w);
    r4.w = 1.17647099 * r3.w;
    r4.w = min(1, r4.w);
    r5.z = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.z * r4.w;
    r3.w = -1 + r3.w;
    r3.w = -6.66666794 * r3.w;
    r3.w = min(1, r3.w);
    r5.z = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r5.z * r3.w;
    r3.w = r4.w * r3.w + -0.5;
    r8.yz = r3.ww * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r9.zw = float2(-0.5,-0.5) + r9.xx;
    r5.zw = r9.zy + -r8.xy;
    r6.zw = float2(1,6) * r5.zw;
    r3.w = dot(r6.zw, r6.zw);
    r3.w = sqrt(r3.w);
    r3.w = -0.400000006 + r3.w;
    r3.w = -2.5 * r3.w;
    r3.w = max(0, r3.w);
    r4.w = r3.w * -2 + 3;
    r6.z = 1 / r8.z;
    r3.y = saturate(r6.z * r3.y);
    r6.z = r3.y * -2 + 3;
    r3.y = r3.y * r3.y;
    r3.y = r6.z * r3.y;
    r6.z = sqrt(r3.y);
    r6.w = 0.200000003 * r6.z;
    r5.z = -r6.z * 0.200000003 + abs(r5.z);
    r6.w = 1 / -r6.w;
    r5.z = saturate(r6.w * r5.z);
    r6.w = r5.z * -2 + 3;
    r5.z = r5.z * r5.z;
    r5.z = r6.w * r5.z;
    r5.w = 0.0199999996 + r5.w;
    r5.w = saturate(25 * r5.w);
    r6.w = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r6.w * r5.w;
    r3.y = r5.w * r3.y;
    r12.yz = r5.zz * r3.yy;
    r11.xyz = frac(r10.yzw);
    r3.y = r11.x + r9.y;
    r8.w = -0.5 + r3.y;
    r8.xy = r9.wy + -r8.xw;
    r3.y = dot(r8.xy, r8.xy);
    r3.y = sqrt(r3.y);
    r3.y = -0.300000012 + r3.y;
    r3.y = -3.33333302 * r3.y;
    r3.y = max(0, r3.y);
    r5.z = r3.y * -2 + 3;
    r3.yw = r3.yw * r3.yw;
    r3.y = r5.z * r3.y;
    r3.y = r3.y * r6.z;
    r3.y = r3.y * r5.w;
    r3.y = r4.w * r3.w + r3.y;
    r5.zw = floor(r10.zw);
    r6.zw = float2(-0.5,-0.5) + r11.yz;
    r3.w = dot(r5.zw, float2(107.449997,3543.65405));
    r8.xyz = float3(0.137869999,0.113689996,0.103100002) * r3.www;
    r8.xyz = frac(r8.xyz);
    r9.xyz = float3(19.1900005,19.1900005,19.1900005) + r8.yxz;
    r3.w = dot(r8.zyx, r9.xyz);
    r8.xyz = r8.xyz + r3.www;
    r9.xyz = r8.zzy + r8.yxx;
    r8.xyz = r9.xyz * r8.xyz;
    r8.xyz = frac(r8.xyz);
    r5.zw = float2(-0.5,-0.5) + r8.xy;
    r5.zw = -r5.zw * float2(0.699999988,0.699999988) + r6.zw;
    r3.w = dot(r5.zw, r5.zw);
    r3.w = sqrt(r3.w);
    r3.w = -0.300000012 + r3.w;
    r3.w = -3.33333302 * r3.w;
    r3.w = max(0, r3.w);
    r4.w = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.w * r3.w;
    r4.w = 10 * r8.z;
    r4.w = frac(r4.w);
    r3.w = r4.w * r3.w;
    r4.w = cb2[13].x * 0.00499999989 + r8.z;
    r4.w = frac(r4.w);
    r5.z = 40 * r4.w;
    r5.z = min(1, r5.z);
    r5.w = r5.z * -2 + 3;
    r5.z = r5.z * r5.z;
    r5.z = r5.w * r5.z;
    r4.w = -1 + r4.w;
    r4.w = -1.02564096 * r4.w;
    r4.w = min(1, r4.w);
    r5.w = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.w * r4.w;
    r4.w = r5.z * r4.w;
    r3.w = r4.w * r3.w;
    r1.w = r3.y * r1.w;
    r0.w = r3.w * r0.w + r1.w;
    r0.w = -0.300000012 + r0.w;
    r0.w = saturate(0.588235319 * r0.w);
    r1.w = r0.w * -2 + 3;
    r0.w = r0.w * r0.w;
    r3.y = r1.w * r0.w;
    r8.x = r1.w * r0.w + -r2.w;
    r8.yz = r2.zz * r2.yy + -r3.yy;
    r2.yzw = float3(0.0450000018,0.0450000018,0.0450000018) * r12.xyz;
    r2.yzw = min(float3(1,1,1), r2.yzw);
    r0.w = min(1, r12.x);
    r2.yzw = r2.yzw * r0.www + r8.xyz;
    r2.yzw = max(float3(-0.0250000004,-0.0250000004,-0.0250000004), r2.yzw);
    r0.z = 1.20000005 * r0.z;
    r0.z = max(0.150000006, r0.z);
    r0.z = min(0.899999976, r0.z);
    r2.yzw = r2.yzw * r0.zzz;
    r0.z = cb1[15].z + -790;
    r0.z = saturate(0.00714285718 * r0.z);
    r0.z = 1 + -r0.z;
    r4.xyz = r2.yzw * r0.zzz + r4.xyz;
  }
  r2.yzw = float3(256,256,256) * r4.xyz;
  r2.yzw = floor(r2.yzw);
  r4.xyz = r4.xyz * float3(256,256,256) + -r2.yzw;
  r4.xyz = float3(8,8,4) * r4.xyz;
  r4.xyz = floor(r4.xyz);
  r0.z = dot(r4.xyz, float3(32,4,1));
  o1.w = 0.00392156886 * r0.z;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r2.yzw;
  r6.y = 0.001953125 * r0.y;
  r5.x = cb2[12].z * v3.x + cb3[45].w;
  r0.yz = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r0.yz);
  r0.y = v2.z * r3.x + -0.349999994;
  r0.y = saturate(1.53846204 * r0.y);
  r0.y = cb5[3].z * r0.y;
  r0.z = -cb2[13].z + 1;
  r0.y = r0.y * r0.z;
  r0.y = r0.y * r2.x;
  r0.z = r6.x * -0.5 + 1;
  r0.z = r0.y * r0.z;
  r0.z = r0.z * -0.5 + 1;
  r7.xyz = r1.xyz * r0.zzz;
  r0.x = saturate(r0.x * r3.z + 0.400000006);
  r0.xz = r0.xx * float2(0.5,0.48828131) + -r6.xy;
  r0.xz = max(float2(0,0), r0.xz);
  r0.xy = r0.xz * r0.yy + r6.xy;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r7.xyzw;
  o2.z = cb11[4].w;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}