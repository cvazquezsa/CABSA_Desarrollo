[Forma]
Clave=EspecificarMontacargistaPosicion
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Especificar Montacarga y Posición
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
BarraAcciones=S
AccionesTamanoBoton=15x5
;ListaAcciones=(Lista)
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
PosicionInicialIzquierda=522
PosicionInicialArriba=284
PosicionInicialAltura=108
PosicionInicialAncho=376
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=119

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.Filtro, config.WMSTipoAComodador)<BR>Asigna(Info.Montacarga, <T><T>)<BR>Asigna(Info.Posicion,<T><T>)
ExpresionesAlCerrar=Asigna(Info.Filtro, nulo)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S


[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

Multiple=S
;ListaAccionesMultiples=(Lista)
ListaAccionesMultiples=(Lista)
Antes=S
AntesExpresiones=Asigna(Info.Estatus,<T>ALTA<T>)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S





[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Visible=S





EjecucionConError=S







EjecucionCondicion=Si SQL(<T>IF EXISTS (SELECT * FROM Agente a JOIN Usuario u ON u.DefAgente=a.Agente WHERE a.Agente = :tAgente AND a.Tipo = :tTipo AND a.Estatus = :tEstatus AND u.Estatus = :tEstatus) SELECT 1 ELSE SELECT 0<T>, Info.Montacarga, Config.WMSTipoAcomodador, Info.Estatus, Info.Estatus)=1 y(SQL(<T>IF EXISTS (SELECT * FROM AlmPos WHERE Posicion = :tPosicion AND Almacen = :tAlmacen AND Tipo = :tTipo) SELECT 1 ELSE SELECT 0<T>, Info.Posicion, Info.Almacen, Info.Tipo) = 1)<BR>Entonces<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin
EjecucionMensaje=<T>Posición o Acomodador Incorrectos<T>
[Lista.Columnas]
Posicion=64
Tipo=106
ArticuloEsp=124
Pasillo=45
Nivel=37
Zona=64
Descripcion=130
Estatus=54














0=105
1=247

[(Variables).info.Montacarga]
Carpeta=(Variables)
Clave=info.Montacarga
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[(Variables).ListaEnCaptura]
(Inicio)=info.Montacarga
info.Montacarga=Info.Posicion
Info.Posicion=(Fin)

[(Variables).Info.Posicion]
Carpeta=(Variables)
Clave=Info.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






































[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Aceptar
Aceptar=(Fin)







































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
