
[Forma]
Clave=TipoRegistroD
Icono=0
Modulos=(Todos)
Nombre=Histórico y Programación de Tipos de Registro

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Nombre)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=325
PosicionInicialArriba=235
PosicionInicialAlturaCliente=403
PosicionInicialAncho=789
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoRegistroD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)





FiltroGeneral=TipoRegistroD.TipoRegistro=<T>{Info.Nombre}<T>
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
FechaD=94
FechaA=94
Porcentaje=64
Concepto=169
Referencia=157

Tasa=52

CodigoFiscal=160


Mascara=226
TipoContacto=111
VigenciaD=94
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S



ActivoCondicion=No TipoRegistroD:TipoRegistroD.TieneMovimientos


[Lista.TipoRegistroD.Concepto]
Carpeta=Lista
Clave=TipoRegistroD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TipoRegistroD.Mascara]
Carpeta=Lista
Clave=TipoRegistroD.Mascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TipoRegistroD.TipoContacto]
Carpeta=Lista
Clave=TipoRegistroD.TipoContacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.TipoRegistroD.Referencia]
Carpeta=Lista
Clave=TipoRegistroD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TipoRegistroD.VigenciaD]
Carpeta=Lista
Clave=TipoRegistroD.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=TipoRegistroD.Concepto
TipoRegistroD.Concepto=TipoRegistroD.Mascara
TipoRegistroD.Mascara=TipoRegistroD.TipoContacto
TipoRegistroD.TipoContacto=TipoRegistroD.Referencia
TipoRegistroD.Referencia=TipoRegistroD.VigenciaD
TipoRegistroD.VigenciaD=(Fin)







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Eliminar
Eliminar=(Fin)
