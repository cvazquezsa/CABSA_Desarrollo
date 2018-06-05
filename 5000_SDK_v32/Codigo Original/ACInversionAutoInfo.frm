[Forma]
Clave=ACInversionAutoInfo
Nombre=Inversión
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=234
PosicionInicialArriba=340
PosicionInicialAlturaCliente=317
PosicionInicialAncho=812
PosicionColumna1=53
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Totalizadores=S
PosicionSeccion1=89
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Temp.Reg, SQL(<T>SELECT TipoCredito, TipoTasa, Condicion FROM LC WHERE LineaCredito=:tLC<T>, Info.LineaCredito))<BR>Asigna(Info.TipoCredito, Temp.Reg[1])<BR>Asigna(Info.TipoTasa, Temp.Reg[2])<BR>Asigna(Info.Condicion, Temp.Reg[3])

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ACInversionAuto
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
HojaIndicador=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ACInversionAuto.CxpID={Info.ID}

[Lista.ACInversionAuto.Accion]
Carpeta=Lista
Clave=ACInversionAuto.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ACInversionAuto.Importe]
Carpeta=Lista
Clave=ACInversionAuto.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ACInversionAuto.CtaDinero]
Carpeta=Lista
Clave=ACInversionAuto.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ACInversionAuto
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.ACInversionAuto.Beneficiario]
Carpeta=Ficha
Clave=ACInversionAuto.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ACInversionAuto.Nota]
Carpeta=Ficha
Clave=ACInversionAuto.Nota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ACInversionAuto.TipoCredito]
Carpeta=Ficha
Clave=ACInversionAuto.TipoCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.ACInversionAuto.TipoTasa]
Carpeta=Ficha
Clave=ACInversionAuto.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ACInversionAuto.Condicion]
Carpeta=Ficha
Clave=ACInversionAuto.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Accion=75
Importe=94
CtaDinero=81
Descripcion=130

[Lista.CtaDinero.Descripcion]
Carpeta=Lista
Clave=CtaDinero.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.TipoTasa.Descripcion]
Carpeta=Ficha
Clave=TipoTasa.Descripcion
Editar=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
Totalizadores1=Saldo
Totalizadores2=Info.Importe-Suma(ACInversionAuto:ACInversionAuto.Importe)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=$00808040
CampoColorFondo=Plata
ListaEnCaptura=Saldo
CarpetaVisible=S

[(Carpeta Totalizadores).Saldo]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ACInversionAuto.Accion
ACInversionAuto.Accion=ACInversionAuto.Importe
ACInversionAuto.Importe=ACInversionAuto.CtaDinero
ACInversionAuto.CtaDinero=CtaDinero.Descripcion
CtaDinero.Descripcion=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=ACInversionAuto.Beneficiario
ACInversionAuto.Beneficiario=ACInversionAuto.Nota
ACInversionAuto.Nota=ACInversionAuto.TipoCredito
ACInversionAuto.TipoCredito=ACInversionAuto.Condicion
ACInversionAuto.Condicion=ACInversionAuto.TipoTasa
ACInversionAuto.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=(Fin)
