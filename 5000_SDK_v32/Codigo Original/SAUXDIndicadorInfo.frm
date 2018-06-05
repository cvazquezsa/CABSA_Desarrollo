
[Forma]
Clave=SAUXDIndicadorInfo
Icono=0
Modulos=(Todos)
Nombre=Indicadores

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=538
PosicionInicialArriba=208
PosicionInicialAlturaCliente=394
PosicionInicialAncho=523
Comentarios=Lista(Info.Producto, Info.Servicio)
ListaAcciones=Cerrar

PosicionSec1=154
[Ficha.Columnas]
Servicio=124
Producto=124
Campo=111
Valor=84
Observaciones=253


Indicador=124
ValorNumerico=72
ValorFijo=304
ValorVariable=604
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Navegador (Documentos)
Navegador (Documentos)=(Fin)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXDIndicador
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=SAUXDIndicador.ID = <T>{Info.ID}<T> AND<BR>SAUXDIndicador.Producto = <T>{Info.Producto}<T> AND<BR>SAUXDIndicador.Servicio = <T>{Info.Servicio}<T>
[Lista.SAUXDIndicador.Indicador]
Carpeta=Lista
Clave=SAUXDIndicador.Indicador
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata


[Ficha.SAUXDIndicador.Indicador]
Carpeta=Ficha
Clave=SAUXDIndicador.Indicador
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.SAUXDIndicador.ValorNumerico]
Carpeta=Ficha
Clave=SAUXDIndicador.ValorNumerico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=30
EditarConBloqueo=S
EspacioPrevio=S
[Ficha.SAUXDIndicador.ValorFijo]
Carpeta=Ficha
Clave=SAUXDIndicador.ValorFijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

EditarConBloqueo=S
[Ficha.SAUXDIndicador.ValorVariable]
Carpeta=Ficha
Clave=SAUXDIndicador.ValorVariable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50x3
ColorFondo=Blanco

EditarConBloqueo=S
[Ficha.SAUXDIndicador.Observaciones]
Carpeta=Ficha
Clave=SAUXDIndicador.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50x2
ColorFondo=Blanco


EditarConBloqueo=S
EspacioPrevio=S
[Lista.Columnas]
0=-2
1=-2

























Indicador=112






ValorVariable=289
Valor=368
Tipo=114
[Ficha.ListaEnCaptura]
(Inicio)=SAUXDIndicador.Indicador
SAUXDIndicador.Indicador=SAUXDIndicador.ValorNumerico
SAUXDIndicador.ValorNumerico=SAUXDIndicador.ValorFijo
SAUXDIndicador.ValorFijo=SAUXDIndicador.ValorVariable
SAUXDIndicador.ValorVariable=SAUXDIndicador.Observaciones
SAUXDIndicador.Observaciones=(Fin)







































[Lista.SAUXDIndicador.Valor]
Carpeta=Lista
Clave=SAUXDIndicador.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)











[Lista.ListaEnCaptura]
(Inicio)=SAUXDIndicador.Indicador
SAUXDIndicador.Indicador=SAUXDIndicador.Valor
SAUXDIndicador.Valor=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
