
[Forma]
Clave=PersonalPropSuc
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=<T>Sucursal<T>

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=504
PosicionInicialArriba=226
PosicionInicialAlturaCliente=76
PosicionInicialAncho=229
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.Sucursal
CarpetaVisible=S

PermiteEditar=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Plata
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
[(Variables).Info.Sucursal]
Carpeta=(Variables)
Clave=Info.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
0=91
1=267

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
EnBarraAcciones=S
Activo=S
Visible=S

ListaAccionesMultiples=(Lista)
[Acciones.Aceptar.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Acepta]
Nombre=Acepta
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Aceptar.Config]
Nombre=Config
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Rama, <T>SUC<T>)<BR>Asigna(Info.Cuenta, Info.Sucursal)<BR>Asigna(Info.Descripcion, SQL(<T>SELECT Nombre FROM Sucursal WHERE Sucursal = :nSucursal<T>,Info.Sucursal))

[Acciones.Aceptar.Abrir]
Nombre=Abrir
Boton=0
TipoAccion=Formas
ClaveAccion=PersonalPropValor
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Config
Config=Abrir
Abrir=Acepta
Acepta=(Fin)
