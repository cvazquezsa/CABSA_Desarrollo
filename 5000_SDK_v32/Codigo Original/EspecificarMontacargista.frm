[Forma]
Clave=EspecificarMontacargista
Nombre=<T>Especificar Acomodador<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
PosicionInicialIzquierda=661
PosicionInicialArriba=387
PosicionInicialAltura=108
PosicionInicialAncho=278
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=87

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Filtro, config.WMSTipoAComodador)
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
ListaEnCaptura=info.Montacarga
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
ListaAccionesMultiples=(Lista)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Montacarga, <T><T>)




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







EjecucionCondicion=SQL(<T>IF EXISTS (SELECT * FROM Agente WHERE Agente = :tAgente AND Tipo = :tTipo) SELECT 0 ELSE SELECT 1<T>, Info.Montacarga, Config.WMSTipoAcomodador)=0
EjecucionMensaje=<T>Acomodador Incorrecto<T>
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




















[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Aceptar
Aceptar=(Fin)













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
