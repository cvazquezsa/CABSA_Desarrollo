
[Forma]
Clave=RepReciboNomina
Icono=0
Modulos=(Todos)
Nombre=Recibo de Nómina
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=475
PosicionInicialArriba=278
PosicionInicialAlturaCliente=207
PosicionInicialAncho=330
ListaAcciones=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
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
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Ficha.RepParam.InfoPersonal]
Carpeta=Ficha
Clave=RepParam.InfoPersonal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Ficha.RepParam.InfoDepartamento]
Carpeta=Ficha
Clave=RepParam.InfoDepartamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoPuesto]
Carpeta=Ficha
Clave=RepParam.InfoPuesto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoCatPersonal]
Carpeta=Ficha
Clave=RepParam.InfoCatPersonal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoGrupoPersonal]
Carpeta=Ficha
Clave=RepParam.InfoGrupoPersonal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


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


[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Caso RepParam:RepParam.InfoNOMTipoRecibo<BR>  Es <T>Aspel<T> Entonces URL(General.RSReportASPX+<T>/ReportesNomina/ReciboNomina&Estacion=<T>+EstacionTrabajo)<BR>  Es <T>Tres por hoja<T> Entonces URL(General.RSReportASPX+<T>/ReportesNomina/ReciboNominaTres&Estacion=<T>+EstacionTrabajo)<BR>Fin
[Acciones.Nomina]
Nombre=Nomina
Boton=50
NombreEnBoton=S
NombreDesplegar=Nómina
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EspecificarMovNominaRepParam
Activo=S
Visible=S


































Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Nomina.Forma]
Nombre=Forma
Boton=0
TipoAccion=Formas
ClaveAccion=EspecificarMovNominaRepParam
Activo=S
Visible=S

[Acciones.Nomina.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S





[Acciones.Nomina.ListaAccionesMultiples]
(Inicio)=Forma
Forma=Actualizar
Actualizar=(Fin)








[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoPersonal
RepParam.InfoPersonal=RepParam.InfoDepartamento
RepParam.InfoDepartamento=RepParam.InfoPuesto
RepParam.InfoPuesto=RepParam.InfoCatPersonal
RepParam.InfoCatPersonal=RepParam.InfoGrupoPersonal
RepParam.InfoGrupoPersonal=RepParam.InfoNOMTipoRecibo
RepParam.InfoNOMTipoRecibo=(Fin)

[Ficha.RepParam.InfoNOMTipoRecibo]
Carpeta=Ficha
Clave=RepParam.InfoNOMTipoRecibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=Nomina
Nomina=(Fin)
