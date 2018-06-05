[Forma]
Clave=Tasa
Nombre=Tasas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=462
PosicionInicialArriba=193
PosicionInicialAlturaCliente=446
PosicionInicialAncho=676
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Tasa
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.Tasa.Tasa]
Carpeta=Lista
Clave=Tasa.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Tasa.Dias]
Carpeta=Lista
Clave=Tasa.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Tasa=188
Porcentaje=48
Dias=34
Tipo=121
Fecha=94
Estatus=58
Grupo=144

CalcularIVA=64
[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalles
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=TasaD
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Tasa:Tasa.Tasa)
AntesExpresiones=Asigna(Info.Tasa, Tasa:Tasa.Tasa)

[Lista.Tasa.Porcentaje]
Carpeta=Lista
Clave=Tasa.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Tasa.Fecha]
Carpeta=Lista
Clave=Tasa.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Tasa.Estatus]
Carpeta=Lista
Clave=Tasa.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Tasa.Grupo]
Carpeta=Lista
Clave=Tasa.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.TasaGrupo]
Nombre=TasaGrupo
Boton=91
NombreEnBoton=S
NombreDesplegar=&Grupos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TasaGrupo
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=Tasa.Tasa
Tasa.Tasa=Tasa.Fecha
Tasa.Fecha=Tasa.Porcentaje
Tasa.Porcentaje=Tasa.Dias
Tasa.Dias=Tasa.Estatus
Tasa.Estatus=Tasa.Grupo
Tasa.Grupo=Tasa.CalcularIVA
Tasa.CalcularIVA=(Fin)

[Lista.Tasa.CalcularIVA]
Carpeta=Lista
Clave=Tasa.CalcularIVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalles
Detalles=TasaGrupo
TasaGrupo=(Fin)
