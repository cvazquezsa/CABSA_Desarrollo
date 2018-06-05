[Forma]
Clave=EspecificarAgenteWMS
Nombre=<T>Especificar Acomodador<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=RepParam
CarpetaPrincipal=RepParam
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
PosicionInicialIzquierda=664
PosicionInicialArriba=376
PosicionInicialAltura=108
PosicionInicialAncho=271
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=109


[(Variables).Info.Agente]
Carpeta=(Variables)
Clave=Info.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S




[(Variables).ListaEnCaptura]
(Inicio)=Info.Agente
Info.Agente=info.Montacarga
info.Montacarga=(Fin)

[(Variables).info.Montacarga]
Carpeta=(Variables)
Clave=info.Montacarga
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[RepParam]
Estilo=Ficha
PestanaOtroNombre=S
Clave=RepParam
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S





ListaEnCaptura=(Lista)



Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=RepParam.Estacion={EstacionTrabajo}
[RepParam.RepParam.InfoAcomodador]
Carpeta=RepParam
Clave=RepParam.InfoAcomodador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoMontacarga]
Carpeta=RepParam
Clave=RepParam.InfoMontacarga
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



LineaNueva=S
[Forma.ListaCarpetas]
(Inicio)=(Variables)
(Variables)=RepParam
RepParam=(Fin)





[Lista.Columnas]
0=105
1=247




























[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoAcomodador
RepParam.InfoAcomodador=RepParam.InfoMontacarga
RepParam.InfoMontacarga=(Fin)

























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
